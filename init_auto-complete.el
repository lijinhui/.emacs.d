;; -*- Emacs-Lisp -*-

(add-to-list 'load-path "~/.emacs.d/python-mode/")
(add-to-list 'load-path "~/.emacs.d/ropemacs/")
(add-to-list 'load-path "~/.emacs.d/Pymacs-0.23/")
(require 'python)
(require 'ipython)
(require 'highlight-symbol)
(custom-set-faces
 '(my-tab-face            ((((class color)) (:background "grey10"))) t)
 '(my-trailing-space-face ((((class color)) (:background "red"))) t)
 '(my-long-line-face ((((class color)) (:background "red"))) t))

(defun my-python-mode-hook ()
  (highlight-symbol-mode t)
  (setq show-trailing-whitespace t)    
  )

(add-hook 'python-mode-hook 'my-python-mode-hook)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))


(require 'yasnippet)
;;----------------yasnippet----------------------
(print "yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory (concat  "~/.emacs.d/snippets"))
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


(add-to-list 'load-path "~/.emacs.d/auto-complete/")
(require 'auto-complete)
(require 'auto-complete-config)
(require 'auto-complete-yasnippet)
(require 'auto-complete-c)
(require 'auto-complete-etags)
(require 'auto-complete-extension)
(require 'auto-complete-octave)
(require 'auto-complete-verilog)
(require 'ac-anything)
;;(require 'rcodetools)
(require 'auto-complete+)

;;(require 'javascript-mode "javascript")
;;(require 'js2-mode)
;;(require 'css-mode)

;; After do this, isearch any string, M-: (match-data) always
;; return the list whose elements is integer
(global-auto-complete-mode 1)

;; 不让回车的时候执行`ac-complete', 因为当你输入完一个
;; 单词的时候, 很有可能补全菜单还在, 这时候你要回车的话,
;; 必须要干掉补全菜单, 很麻烦, 用M-j来执行`ac-complete'
(defun apply-define-key (map key-pairs)
  (dolist (key-pair key-pairs)
    (define-key map (eval `(kbd ,(nth 0 key-pair))) (nth 1 key-pair))))

(apply-define-key
 ac-complete-mode-map
 `(("<return>"   ac-complete)
   ("RET"        ac-complete)
   ("M-j"        ac-complete)
   ("<C-return>" ac-complete)
   ("M-n"        ac-next)
   ("M-p"        ac-previous)))

(setq ac-dwim t)
(setq ac-candidate-max ac-candidate-menu-height)

(set-default 'ac-sources
             '(;;ac-source-semantic
               ac-source-yasnippet
               ac-source-abbrev
               ac-source-words-in-buffer
               ac-source-words-in-all-buffer
               ac-source-imenu
               ac-source-files-in-current-dir
               ac-source-filename))
;;(setq ac-modes ac+-modes)

(setq
 ac-trigger-commands
 '(self-insert-command
   autopair-insert-or-skip-quote
   autopair-backspace
   autopair-extra-skip-close-maybe
   c-electric-backspace
   c-electric-backspace-kill))



;; setup pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)



(defvar ac-ropemacs-loaded nil)
(defun ac-ropemacs-require ()
  (unless ac-ropemacs-loaded
    ;; Almost people hate rope to use `C-x p'.
    (if (not (boundp 'ropemacs-global-prefix))
        (setq ropemacs-global-prefix nil))
    (pymacs-load "ropemacs" "rope-")
    (setq ropemacs-enable-autoimport t)
    (setq ac-ropemacs-loaded t)))

(defvar ac-ropemacs-completions-cache nil)

(defface ac-ropemacs-candidate-face
  '((t (:background "pink" :foreground "black")))
  "Face for yasnippet candidate.")

(defface ac-ropemacs-selection-face
  '((t (:background "coral3" :foreground "white"))) 
  "Face for the yasnippet selected candidate.")


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
                    (all-completions ac-prefix ac-ropemacs-completions-cache)))
    
    (candidate-face . ac-ropemacs-candidate-face)
    (selection-face . ac-ropemacs-selection-face)))

(defun ac-ropemacs-setup ()
  (ac-ropemacs-require)
;;  (setq ac-sources (append (list 'ac-source-ropemacs) ac-sources))
  (set (make-local-variable 'ac-sources)
       (append ac-sources '(ac-source-ropemacs) ))
  (setq ac-omni-completion-sources '(("\\." ac-source-ropemacs))))

(defun ac-ropemacs-init ()
  (add-hook 'python-mode-hook 'ac-ropemacs-setup))

(add-hook 'python-mode-hook 'ac-ropemacs-setup)



(defun ac-settings-4-lisp ()
  "Auto complete settings for lisp mode."
  (setq ac-omni-completion-sources '(("\\<featurep\s+'" ac+-source-elisp-features)
                                     ("\\<require\s+'"  ac+-source-elisp-features)
                                     ("\\<load\s+\""    ac-source-emacs-lisp-features)))
  (ac+-apply-source-elisp-faces)
  (setq ac-sources
        '(ac-source-yasnippet
          ac-source-symbols
          ;; ac-source-semantic
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-all-buffer
          ;; ac-source-imenu
          ac-source-files-in-current-dir
          ac-source-filename)))

(defun ac-settings-4-java ()
  (setq ac-omni-completion-sources (list (cons "\\." '(ac-source-semantic))
                                         (cons "->" '(ac-source-semantic))))
  (setq ac-sources
        '(;;ac-source-semantic
          ac-source-yasnippet
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-all-buffer
          ac-source-files-in-current-dir
          ac-source-filename)))

(defun ac-settings-4-c ()
  (setq ac-omni-completion-sources (list (cons "\\." '(ac-source-semantic))
                                         (cons "->" '(ac-source-semantic))))
  (setq ac-sources
        '(ac-source-yasnippet
          ac-source-c-keywords
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-all-buffer
          ac-source-files-in-current-dir
          ac-source-filename)))

(defun ac-settings-4-cpp ()
            (setq ac-omni-completion-sources
                  (list (cons "\\." '(ac-source-semantic))
                        (cons "->" '(ac-source-semantic))))
            (setq ac-sources
                  '(ac-source-yasnippet
                    ac-source-c++-keywords
                    ac-source-abbrev
                    ac-source-words-in-buffer
                    ac-source-words-in-all-buffer
                    ac-source-files-in-current-dir
                    ac-source-filename)))

(defun ac-settings-4-text ()
            (setq ac-sources
                  '(;;ac-source-semantic
                    ac-source-yasnippet
                    ac-source-abbrev
                    ac-source-words-in-buffer
                    ac-source-words-in-all-buffer
                    ac-source-imenu)))

(defun ac-settings-4-eshell ()
            (setq ac-sources
                  '(;;ac-source-semantic
                    ac-source-yasnippet
                    ac-source-abbrev
                    ac-source-words-in-buffer
                    ac-source-words-in-all-buffer
                    ac-source-files-in-current-dir
                    ac-source-filename
                    ac-source-symbols
                    ac-source-imenu)))

(defun ac-settings-4-ruby ()
            (setq ac-omni-completion-sources
                  (list (cons "\\." '(ac-source-rcodetools))
                        (cons "::" '(ac-source-rcodetools)))))

(defun ac-settings-4-html ()
  (setq ac-sources
        '(;;ac-source-semantic
          ac-source-yasnippet
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-all-buffer
          ac-source-files-in-current-dir
          ac-source-filename)))

(defun ac-settings-4-tcl ()
  (setq ac-sources
        '(;;ac-source-semantic
          ac-source-yasnippet
          ac-source-abbrev
          ac-source-words-in-buffer
          ac-source-words-in-all-buffer
          ac-source-files-in-current-dir
          ac-source-filename)))

;;(dolist (hook (list 'lisp-mode-hook 'emacs-lisp-mode-hook 'lisp-interaction-mode-hook
;;                    'svn-log-edit-mode-hook 'change-log-mode-hook))
;;  (add-hook hook 'ac-settings-4-lisp))

;;(apply-args-list-to-fun
;; 'add-hook
;; `(('java-mode-hook   'ac-settings-4-java)
;;   ('c-mode-hook      'ac-settings-4-c)
;;   ('c++-mode-hook    'ac-settings-4-cpp)
;;   ('text-mode-hook   'ac-settings-4-text)
;;   ('eshell-mode-hook 'ac-settings-4-eshell)
;;   ('ruby-mode-hook   'ac-settings-4-ruby)
;;   ('html-mode-hook   'ac-settings-4-html)
;;   ('java-mode-hook   'ac-settings-4-java)
;;   ('tcl-mode-hook    'ac-settings-4-tcl)))

;;(dolist (mode ac-modes)
;;  (let ((mode-name (symbol-name mode)))
;;    (when (and (intern-soft mode-name) (intern-soft (concat mode-name "-map")))
;;    (define-key (symbol-value (concat-name mode-name "-map")) (kbd "C-c a") 'ac-start))))

(provide 'auto-complete-settings)
