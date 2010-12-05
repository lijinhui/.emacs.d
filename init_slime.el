(add-to-list 'load-path "~/.emacs.d/slime/")  ; your SLIME directory
(add-to-list 'load-path "~/.emacs.d/slime/contrib/")  ;

(setq inferior-lisp-program "/opt/sbcl/bin/sbcl") ; your Lisp system
(require 'slime)
(slime-setup '(slime-repl slime-js))
(add-hook 'js2-mode-hook
            (lambda ()
              (slime-js-minor-mode 1)))


(add-hook 'css-mode-hook
	  (lambda ()
	    (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)))
