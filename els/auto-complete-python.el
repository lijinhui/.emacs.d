(require 'auto-complete)

;; setup pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(eval-after-load "pymacs"
  '(add-to-list 'pymacs-load-path "~/.emacs.d/emacs_python/"))


(defvar ac-ropemacs-loaded nil)
(defun ac-ropemacs-require ()
  (message "here")
  (unless ac-ropemacs-loaded
    ;; Almost people hate rope to use `C-x p'.
    (if (not (boundp 'ropemacs-global-prefix))
        (setq ropemacs-global-prefix nil))
    (pymacs-load "ropemacs" "rope-")
    (setq ropemacs-enable-autoimport t)
    (setq ac-ropemacs-loaded t)))

(defvar ac-ropemacs-completions-cache nil)

(defvar ac-source-ropemacs
  '((init
     . (lambda ()
         (setq ac-ropemacs-completions-cache
               (mapcar
                (lambda (completion)
                  (concat ac-prefix completion))
                (ignore-errors
                  (rope-completions))))))
    (candidates . (lambda ()
                    (all-completions ac-prefix ac-ropemacs-completions-cache)))))

(defun ac-ropemacs-setup ()
  (ac-ropemacs-require)
  ;(setq ac-sources (append (list 'ac-source-ropemacs) ac-sources))
  (setq ac-omni-completion-sources '(("\\." ac-source-ropemacs))))

(defun ac-python-prefix-function()
  (interactive)
  (setq pp (point))
  (re-search-backward "[\\n|\\s-]")
  (message (concat "find" (buffer-substring (match-end 0) pp)))
)


(defun ac-ropemacs-init ()
  (add-hook 'python-mode-hook 'ac-ropemacs-setup))

(provide 'auto-complete-python)
