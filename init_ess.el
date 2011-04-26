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