
(add-to-list 'load-path "~/.emacs.d/python-mode/")
(add-to-list 'load-path "~/.emacs.d/ropemacs/")
(add-to-list 'load-path "~/.emacs.d/Pymacs-0.23/")
(require 'python)
(require 'yasnippet)
;;----------------yasnippet----------------------
(print "yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory (concat  "/mnt/f/lijinhui/.emacs.d/snippets"))
;;(setq yas/trigger-key (kbd "C-c C-j"))
(print "end of yasnippet")
;;--------------end of yasnippet----------------------
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                                yas/ido-prompt
                                    yas/completing-prompt))
(require 'dropdown-list)
;You can customize yas/text-popup-function to set it to a more useful way.
;If you download and install dropdown-list.el, you can

(setq yas/text-popup-function
      #'yas/dropdown-list-popup-for-template)

;It's really awesome! You can use C-n , C-p or even number shortcut to select the candidates. 
;If you like it, you might also want to

(setq yas/window-system-popup-function
      #'yas/dropdown-list-popup-for-template)




















(setq pymacs-load-path '("~/python/"))
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;;; Initialize Rope

(pymacs-load "ropemacs" "rope-")

(setq ropemacs-enable-autoimport t)

;;(global-auto-complete-mode t)  
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))


(add-to-list 'load-path (concat "~/.emacs.d/" "company"))
(autoload 'company-mode "company" nil t)
(setq company-minimum-prefix-length 2)
(setq company-idle-delay 0.4)
(defun company-my-backend (command &optional arg &rest ignored)
  (case command
    ('prefix (when (looking-back "foo\\>")
               (match-string 0)))
    ('candidates (list "foobar" "foobaz" "foobarbaz"))
    ('meta (format "This value is named %s" arg))))


;;(add-to-list  'company-backends 'company-my-backend)
(require 'company)
(global-company-mode)

(require 'company-yasnippet)
;;(add-to-list 'company-backends 'company-yasnippet)

;; complete only after self insert command
(setq company-begin-commands '(self-insert-command))



;; mode-hook
(dolist (hook (list
	       
               'emacs-lisp-mode-hook

               'lisp-mode-hook

               'lisp-interaction-mode-hook

               'scheme-mode-hook

               'c-mode-common-hook

               'python-mode-hook

               'haskell-mode-hook

               'asm-mode-hook

               'emms-tag-editor-mode-hook

               'sh-mode-hook))
  (add-hook hook 'company-mode))
