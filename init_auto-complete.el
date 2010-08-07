;; -*- Emacs-Lisp -*-

(add-to-list 'load-path "~/.emacs.d/python-mode/")
(add-to-list 'load-path "~/.emacs.d/ropemacs/")
(add-to-list 'load-path "~/.emacs.d/Pymacs-0.23/")
(require 'python)
(setq ipython-command "~/software/ipython/ipython.py")
(setq py-python-command-args '("-pylab" "--colors" "Linux"))
(add-to-list 'load-path "~/software/ipython/docs/emacs/")
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


(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3/")
(require 'auto-complete)
(require 'auto-complete-config)
(setq ac-auto-start t)
(add-to-list 'ac-modes 'nxml-mode)

;; After do this, isearch any string, M-: (match-data) always
;; return the list whose elements is integer
(global-auto-complete-mode 1)
(global-set-key (kbd "C-<f8>") 'auto-complete-mode)
;; 不让回车的时候执行`ac-complete', 因为当你输入完一个
;; 单词的时候, 很有可能补全菜单还在, 这时候你要回车的话,
;; 必须要干掉补全菜单, 很麻烦, 用M-j来执行`ac-complete'
(defun apply-define-key (map key-pairs)
  (dolist (key-pair key-pairs)
    (define-key map (eval `(kbd ,(nth 0 key-pair))) (nth 1 key-pair))))

(apply-define-key
 ac-complete-mode-map
 `(
   ;;("<return>"   ac-complete)
   ;;("RET"        ac-complete)
   ("C-;"        ac-complete)
   ("<C-return>" ac-complete)
   ("C-n"        ac-next)
   ("C-p"        ac-previous)))

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

;;(pymacs-load "ropemacs" "rope-")
;;(setq ropemacs-enable-autoimport t)

(defun restart-pymacs ()
   "thisandthat."
   (interactive)
   (kill-process "*Pymacs*")
   (pymacs-load "ropemacs" "rope-")
   )

(defvar ac-ropemacs-loaded nil)
(defun ac-ropemacs-require ()
  (unless ac-ropemacs-loaded
    ;; Almost people hate rope to use `C-x p'.
    (if (not (boundp 'ropemacs-global-prefix))
        (setq ropemacs-global-prefix nil))
    (pymacs-load "ropemacs" "rope-")
    (setq ropemacs-enable-autoimport t)
    (setq ac-ropemacs-loaded t)))

(print "ac-source-rope")
(defvar ac-ropemacs-completions-cache nil)

(defface ac-ropemacs-candidate-face
  '((t (:background "pink" :foreground "black")))
  "Face for yasnippet candidate.")

(defface ac-ropemacs-selection-face
  '((t (:background "coral3" :foreground "white"))) 
  "Face for the yasnippet selected candidate.")

(defun ac-ropemacs-action ()
  (interactive)
  (setq calltip (rope-my-get-calltip t))
  ;;(print (format "calltip=%s" calltip))
  (when (and calltip (string-match "(.*)" calltip))
    (setq func-doc (substring calltip (1+ (match-beginning 0)) (1- (match-end 0))))
    (setq rope-snippet
	  (replace-regexp-in-string
	   ;; 1                2  3           4                                      5
	   "\\([_.a-zA-Z]+\\)\\(\\( *= *\\)?\\(\\(?:\".*\"\\)\\|\\(?:[^,]+\\)\\)\\)?\\(,?\\)"
	   "${\\1\\3${\\4}}\\5"
	   func-doc ))
    (setq rope-snippet
	  (replace-regexp-in-string
	   "\\([_.a-zA-Z]+\\) *= *\\(\\(?:\".*\"\\)\\|\\(?:[^,]+\\)\\)"
	   "\\1 = \\2"
	   ;;"topdown=True, onerror=None, followlinks=False"
	   rope-snippet
	   ))
    (setq snippet
	  (replace-regexp-in-string
	   "${}"
	   ""
	   rope-snippet
	   ))
  ;;(print rope-snippet)
    (yas/expand-snippet (concat "(" rope-snippet ")") (point))
  )
)

(defun my-ac-rope-document (candidate)
  ;;;(print (format "ac-prefix=%s, candidate=%s" ac-prefix  candidate))
  (rope-my-get-doc ac-prefix candidate)
  )


(require 'thingatpt)

(defun my-python-symbol ()
  "thisandthat."
  (interactive)
  (let* ((bol (point-at-bol))
	 (start (point-at-bol))
	 (end (point))
	 (result (point))
	 (prefix ""))
    
    (while (< start end)
      (let* ((str (buffer-substring-no-properties start end)))
	;;(print (format "%s:%s %s" start end str))
	(string-match  "[_a-zA-Z][_.0-9a-zA-Z]*" str)
	(if (equal (- (match-end 0) (match-beginning 0))
		 (- end start))
	  (progn
	    (setq prefix (buffer-substring-no-properties start end))
	    ;;;(print (format "%s:%s" prefix start))
	    (setq result start)
	    (setq start end))
	  (setq start (1+ start))

	  )))
    result))



(ac-define-prefix 'python-prefix-dot 'my-python-symbol)
;;(ac-define-prefix 'rope-prefix-find 'ac-rope-prefix-find)
;;(ac-define-prefix 'prefix-bol 'point-at-bol)

(defun ac-rope-candidates-func ()
  "thisandthat."
  (interactive)
  (progn 
    (if (string= "." (buffer-substring (- (point) 1) (point)))
	(setq ac-ropemacs-completions-cache
	      (mapcar
	       (lambda (completion)
		 (concat ac-prefix completion))
	       (ignore-errors
		 (rope-completions)))))
    ;;;(print "cache:::::::::")
    ;;;(print ac-prefix)
    ;;;(print (all-completions ac-prefix ac-ropemacs-completions-cache))
    (all-completions ac-prefix ac-ropemacs-completions-cache)
    ))

(defvar my-ac-source-ropemacs
  '((init
     . (lambda ()
         (setq ac-ropemacs-completions-cache
               (mapcar
                (lambda (completion)
                  (concat ac-prefix completion))
                (ignore-errors
                  (rope-completions))))
	 ;;(print "rope-completions:")
	 ;;(print ac-ropemacs-completions-cache)
	 ))
    (candidates . ac-rope-candidates-func)
    (action . ac-ropemacs-action)
    ;;(document . rope-my-get-doc)
    (document . my-ac-rope-document)
    (prefix . python-prefix-dot)
    ;(prefix . rope-prefix-find)
    ;(prefix . prefix-bol)
    (limit . 500)
    (candidate-face . ac-ropemacs-candidate-face)
    (selection-face . ac-ropemacs-selection-face)))


(defun ac-ropemacs-setup ()
  (interactive)
  (ac-ropemacs-require)
;;  (setq ac-sources (append (list 'ac-source-ropemacs) ac-sources))
  (set (make-local-variable 'ac-sources)
       '(my-ac-source-ropemacs ac-source-words-in-all-buffer) )
  (setq ac-omni-completion-sources '(("\\." ac-source-ropemacs))))

(defun ac-ropemacs-init ()
  (add-hook 'python-mode-hook 'ac-ropemacs-setup))

(add-hook 'python-mode-hook 'ac-ropemacs-setup)



;;;ipython

(setq ac-ipython-pattern "")
(defun ac-ipython-get-pattern()
  (interactive)
  (let* (
	 (beg (save-excursion (skip-chars-backward "a-z0-9A-Z_./" (point-at-bol))
			      (point)))
	 (end (point))
	 (pattern (buffer-substring-no-properties beg end)))
      ;;(message (format "DEBUG pattern = %S" (list pattern beg end)))
      (list pattern beg end)
      ))
(defun ac-ipython-complete ()
  (interactive)
  (let* ((ugly-return nil)
         (sep ";")
         (python-process (or (get-buffer-process (current-buffer))
			     (get-process py-which-bufname)))
	 (pattern (car (ac-ipython-get-pattern)))
	 (completions nil)
         (comint-preoutput-filter-functions
          (append comint-preoutput-filter-functions
                  '(ansi-color-filter-apply
                    (lambda (string)
                      (setq ugly-return (concat ugly-return string))
                      "")))))

    (process-send-string python-process
			 (format ipython-completion-command-string pattern))
    (accept-process-output python-process)
    (setq completions
	  (split-string (substring ugly-return 0 (position ?\n ugly-return)) sep))
    ;;(message (format "DEBUG completions: %S" completions))
    completions)
  )


(defvar ac-source-ipython
  '(
    ;;init
    ;;. (lambda ()
    ;;	 (setq ac-ipython-completions-cache
    ;;           (ignore-errors
    ;;             (ac-ipython-complete)))
    ;;	 (print (concat "ac-prefix=" ac-prefix))
    ;;	 (print "ipython-completions:")
    ;;	 (print ac-ipython-completions-cache)
    ;;    ;;(setq ac-ipython-completions-cache
    ;;	 ;;(ac-ipython-complete))
    ;;	 ))
    (candidates . (lambda ()
		    ;(print (format "ac-prefix=%S ac-point=%S" ac-prefix ac-point))
		    ;(setq pattern (ac-ipython-get-pattern))
		    ;(setq ac-ipython-pattern (car pattern))
		    ;(setq ac-ipython-point (cadr pattern))
		    ;(print (format "pattern=%S point=%S" ac-ipython-pattern ac-ipython-point))
		    (setq pattern (ac-ipython-get-pattern))
		    (setq ac-prefix (car pattern))
		    (setq ac-point (cadr pattern))
		    ;;(print "all-completions:")
		    ;;(print (ac-ipython-complete))
		    (sort (ac-ipython-complete)
			  (lambda (a b)
			    (string<
			     (if (string= (substring a 0 1) "%")
				 (substring a 1)
			       a)
			     (if (string= (substring b 0 1) "%")
				 (substring b 1)
			       b))))))
    (candidate-face . ac-ropemacs-candidate-face)
    (selection-face . ac-ropemacs-selection-face)))

(defun ac-ipython-setup ()
  (set (make-local-variable 'ac-sources)
       '(ac-source-ipython ac-source-words-in-buffer)
        )
  (setq ac-omni-completion-sources '(("\\." ac-source-ipython)))
  (print "ac-source-ipython done")
  (define-key py-shell-map (kbd "<f8>") 'ipython-to-doctest)
  ;;(auto-complete-mode 1)
  )

(global-set-key (kbd "<f9>") 'py-shell)
(add-hook 'py-shell-hook 'ac-ipython-setup)








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