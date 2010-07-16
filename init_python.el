;;(defun my-highlith-bad-style ()
;;  (interactive)
;;  (hi-lock-line-face-buffer "\\t+" 'my-tab-face)
;;  (hi-lock-line-face-buffer "^.\\{101,\\}$" 'my-long-line-face)
;;  (hi-lock-line-face-buffer "[ \\t]+$" 'my-trailing-space-face )
;;  )

	


(require 'pylint)
;; Configure flymake for python
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
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

;; Set as a minor mode for python
(defun my-python-mode-hook ()
  (setq whitespace-style  '(tabs tab-mark trailing lines-tail ))
  (setq whitespace-tab 'whitespace-trailing)
  ;;long line column size
  (setq whitespace-line-column 100)
  (whitespace-mode t)

  (flymake-mode t)

  (define-key py-mode-map (kbd "<f7>") 'my-add-break-for-ipython-pdb)

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