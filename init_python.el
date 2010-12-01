
(require 'pylint)
;; Configure flymake for python
(when (load "flymake" t)
  (defun my-python-flymake-temp-file (file-name prefix)
    (unless (stringp file-name)
      (error "Invalid file-name"))

    (let* ((dir (file-name-directory file-name))
	   ;; Not sure what this slash-pos is all about, but I guess it's just
	   ;; trying to remove the leading / of absolute file names.
	   (slash-pos (string-match "/" dir))
	   (temp-dir  (expand-file-name (substring dir (1+ slash-pos))
					;;(flymake-get-temp-dir)
					)))
      (concat "/home/lijinhui/python_flymake" 
	  
	      (file-truename (expand-file-name (file-name-nondirectory file-name)
					       ;;temp-dir
					       )))
    ))
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       ;'flymake-create-temp-inplace
		       ;'flymake-create-temp-with-folder-structure
		       'my-python-flymake-temp-file
		       ))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (print local-file)
      (list "epylint" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))



(defun my-add-break-for-ipython-pdb ()
  (interactive)
  (setq line (line-number-at-pos))
  (setq str (format "b %s:%d" (buffer-file-name (current-buffer)) line))
  (with-current-buffer
      (get-buffer "*Python*")
    (end-of-buffer)
    (insert str))
  )



(defun py-outline-level ()
"This is so that `current-column` DTRT in otherwise-hidden text"
;; from ada-mode.el
(let (buffer-invisibility-spec)
  (save-excursion
    (skip-chars-forward "\t ")
    (current-column))))

;; Set as a minor mode for python
(defun my-python-mode-hook ()
  (interactive)
  (setq whitespace-style  '(tabs tab-mark trailing lines-tail ))
  (setq whitespace-tab 'whitespace-trailing)
  ;;long line column size
  (setq whitespace-line-column 100)
  (whitespace-mode t)

  (flymake-mode t)

  (define-key py-mode-map (kbd "<f7>") 'my-add-break-for-ipython-pdb)

  ;;outline
  (interactive)
  (setq outline-regexp "[^ \t\n]\\|[ \t]*\\(@\\|def[ \t]+\\|class[ \t]+\\)")
  (setq outline-level 'py-outline-level)
  (outline-minor-mode t)
  ;(hide-body)
  (show-paren-mode 1)
  (highlight-symbol-mode t)

  (define-key py-mode-map (kbd "C-c h h") 'hide-entry)
  (define-key py-mode-map (kbd "C-c h s") 'show-entry)
  (define-key py-mode-map (kbd "C-c h k") 'hide-entry)
  (define-key py-mode-map (kbd "C-c h j") 'show-entry)
  (define-key py-mode-map (kbd "C-c h a") 'show-all)
  (define-key py-mode-map (kbd "C-c h b") 'hide-body)
)

(add-hook 'python-mode-hook 'my-python-mode-hook)
;;(remove-hook 'python-mode-hook '(lambda () (flymake-mode)))



;;;;flymake-cursor

(defun show-fly-err-at-point ()
  "If the cursor is sitting on a flymake error, display the
message in the minibuffer"
  (interactive)
  (let ((line-no (line-number-at-pos)))
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
	  (let ((err (car (second elem))))
	    (message "%s" (fly-pyflake-determine-message err)))))))

(defun fly-pyflake-determine-message (err)
  "pyflake is flakey if it has compile problems, this adjusts the
message to display, so there is one ;)"
  (cond ((not (or (eq major-mode 'Python) (eq major-mode 'python-mode) t)))
	((null (flymake-ler-file err))
	 ;; normal message do your thing
	 (flymake-ler-text err))
	(t ;; could not compile err
	 (format "compile error, problem on line %s" (flymake-ler-line err)))))

(defadvice flymake-goto-next-error (after display-message activate compile)
  "Display the error in the mini-buffer rather than having to mouse over it"
  (show-fly-err-at-point))

(defadvice flymake-goto-prev-error (after display-message activate compile)
  "Display the error in the mini-buffer rather than having to mouse over it"
  (show-fly-err-at-point))

(defadvice flymake-mode (before post-command-stuff activate compile)
  "Add functionality to the post command hook so that if the
cursor is sitting on a flymake error the error information is
displayed in the minibuffer (rather than having to mouse over
it)"
  (set (make-local-variable 'post-command-hook)
       (cons 'show-fly-err-at-point post-command-hook))) 

;;;;

;;(when (load "flymake" )
;;  (defun flymake-pyflakes-init ()
;;    (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                       'flymake-create-temp-inplace))
;;           (local-file (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;      (list "/usr/local/bin/pyflakes" (list local-file))))
;;  (add-to-list 'flymake-allowed-file-name-masks
;;               '("\\.py\\'" flymake-pyflakes-init)))
;;
;;(add-hook 'find-file-hook 'flymake-find-file-hook)
;;(remove-hook 'find-file-hook 'flymake-find-file-hook)
;;;(load-library "flymake-cursor")  ;在minibuffer显示错误信息
(global-set-key (kbd "<f11>") 'flymake-start-syntax-check)
(global-set-key (kbd "<s-up>") 'flymake-goto-prev-error)
(global-set-key (kbd "<s-down>") 'flymake-goto-next-error)

;;(custom-set-faces
;;     '(flymake-errline ((((class color)) (:underline "red"))))
;;     '(flymake-warnline ((((class color)) (:underline "yellow1")))))
(setq flymake-no-changes-timeout 600)




(defun py-execute-buffer()
  (interactive)
  (setq cmd (concat "python " (buffer-file-name)))
  (setq buf (get-buffer-create "*PYTHON-RUN*"))
  (setq cmd (read-string "run:" cmd))
  (when (length cmd)
    (shell-command cmd buf buf)
    (when (> (with-current-buffer buf (point-max)) 1)
      (switch-to-buffer-other-window buf))
    )
)