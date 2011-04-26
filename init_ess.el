(load "~/.emacs.d/ess-5.13/lisp/ess-site.el")
(setq ess-R-object-tooltip-alist
      '((numeric    . "summary")
        (factor     . "table")
        (integer    . "summary")
        (lm         . "summary")
        (other      . "str")))


(defun ess-R-object-tooltip ()
  "Get info for object at point, and display it in a tooltip."
  (interactive)
  (let ((objname (current-word))
        (curbuf (current-buffer))
        (tmpbuf (get-buffer-create "**ess-R-object-tooltip**")))
    (if objname
        (progn
          (ess-command (concat "class(" objname ")\n")  tmpbuf )   
          (set-buffer tmpbuf)
          (let ((bs (buffer-string)))
            (if (not(string-match "\(object .* not found\)\|unexpected" bs))
                (let* ((objcls (buffer-substring 
                                (+ 2 (string-match "\".*\"" bs)) 
                                (- (point-max) 2)))
                       (myfun (cdr(assoc-string objcls 
                                                ess-R-object-tooltip-alist))))
                  (progn
                    (if (eq myfun nil)
                        (setq myfun 
                              (cdr(assoc-string "other" 
                                                ess-R-object-tooltip-alist))))
                    (ess-command (concat myfun "(" objname ")\n") tmpbuf)
                    (let ((bs (buffer-string)))
                      (progn
                        (set-buffer curbuf)
                        (tooltip-show-at-point bs 0 30)))))))))
    (kill-buffer tmpbuf)))

;; my default key map
(define-key ess-mode-map "\C-c\C-g" 'ess-R-object-tooltip)

(add-hook 'ess-mode-hook
            '(lambda ()
               (outline-minor-mode)
               (setq outline-regexp "\\(^#\\{4,5\\} \\)\\|\\(^[a-zA-Z0-9_\.]+ ?<- ?function(.*{\\)")
               (defun outline-level
                 (lambda () (interactive) (cond ((looking-at "^##### ") 1)((looking-at "^#### ") 2)((looking-at "^[a-zA-Z0-9_\.]+ ?<- ?function(.*{") 3) (t 1000)))
               )))
(defun r-autoyas-exit-snippet-delete-remaining ()
  "Exit yas snippet and delete the remaining argument list."
  (interactive "*")
  (let ((deletefrom (point)))
    (yas/exit-all-snippets)
    (delete-region deletefrom (- (point) 1))))

(defun r-autoyas-expand (&optional funname)
  "Insert argument list (in parentheses) of R function before the
point as intelligent yas snippets and expand the snippets."
  (interactive "*")
  (if (null funname)
      (setq funname (r-autoyas-get-function-name)))
  (ess-command (concat "r.autoyas.create('" funname "')\n")
               (get-buffer-create "*r-autoyas*"))
  (setq novalidfun nil)
  (with-current-buffer "*r-autoyas*"
    (if (< (length (buffer-string)) 10);; '[1] " "' if no valid fun
        (setq novalidfun t)
      (delete-region 1 6)
      (goto-char (point-max))
      (delete-backward-char 2)
      (goto-char (point-min))
      (replace-string "\\\"" "\"")
      (goto-char (point-min))
      (replace-string "\\\\" "\\")
      (setq snippet (buffer-string))))
  (if (equal novalidfun t)
      (message "No valid function!")
      (yas/expand-snippet snippet)))

(defun r-autoyas-get-function-name ()
  "Returns the name of the R function assuming point is currently
right after it."
  (save-excursion
    (let ((posend (point)))
      (backward-sexp 1)
      (let ((rfunname (buffer-substring-no-properties posend (point))))
        (if (posix-string-match "^[a-zA-Z0-9_\.]+$" rfunname)
            rfunname nil)))))

;;(remove-hook 'before-save-hook 'rope-before-save-actions)
;;(remove-hook 'after-save-hook 'rope-after-save-actions)

;;  .Rprofile
;;  r.autoyas.esc <- function(str) {
;;    str <- gsub("$", "\\$", str, fixed=TRUE)
;;    str <- gsub("`", "\\`", str, fixed=TRUE)
;;    return(str)
;;  }
;;  
;;  r.autoyas.create <- function(funname) {
;;    if (!existsFunction(funname)) return(" ")
;;    formals <- formals(funname)
;;    nr <- 0
;;    closebrackets <- 0
;;    str <- NULL
;;    for (field in names(formals)) {
;;      type <- typeof(formals[[field]])
;;      if (type=="symbol" & field!="...") {
;;        nr <- nr+1
;;        str <- append(str, paste(", ${",nr,":",field,"}", sep=""))
;;      } else if (type=="symbol" & field=="...") {
;;        nr <- nr+2
;;        str <- append(str, paste("${",nr-1,":, ${",nr,":",field,"}}", sep=""))
;;      } else if (type=="character") {
;;        nr <- nr+2
;;        str <- append(str, paste("${",nr-1,":, ",field,"=${",nr,":\"",gsub("\"", "\\\"", r.autoyas.esc(encodeString(formals[[field]])), fixed=TRUE),"\"}}", sep=""))
;;      } else if (type=="logical") {
;;        nr <- nr+2
;;        str <- append(str, paste("${",nr-1,":, ",field,"=${",nr,":",as.character(formals[[field]]),"}}", sep=""))
;;      } else if (type=="double") {
;;        nr <- nr+2
;;        str <- append(str, paste("${",nr-1,":, ",field,"=${",nr,":",as.character(formals[[field]]),"}}", sep=""))
;;      } else if (type=="NULL") {
;;        nr <- nr+2
;;        str <- append(str, paste("${",nr-1,":, ",field,"=${",nr,":NULL}}", sep=""))
;;      } else if (type=="language") {
;;        nr <- nr+2
;;        str <- append(str, paste("${",nr-1,":, ",field,"=${",nr,":",r.autoyas.esc(deparse(formals[[field]])),"}}", sep=""))
;;      }
;;    }
;;    str <- paste(str, sep="", collapse="")
;;    if (grepl(", ", str, fixed=TRUE)) str <- sub(", ", "", str) # remove 1st ', ' (from 1st field)
;;    str <- paste("(",str,")", sep="")
;;    return(str)
;;  }
