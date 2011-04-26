(add-to-list 'load-path "~/.emacs.d/global/")
(autoload 'gtags-mode "gtags" "" t)
;;
;; If you hope gtags-mode is on in c-mode then please add c-mode-hook to your
;; $HOME/.emacs like this.
;;
(defun my-c++-hook ()
  (interactive)
  (gtags-mode 1)
  (hs-minor-mode 1)
  (highlight-symbol-mode 1)
  )
(add-hook 'cc-mode-hook 'my-c++-hook)

(add-hook 'c-mode-hook 'my-c++-hook)
(add-hook 'c++-mode-hook 'my-c++-hook)

;;
;; There are two hooks, gtags-mode-hook and gtags-select-mode-hook.
;; The usage of the hook is shown as follows.
;;
;; [Setting to reproduce old 'Gtags mode']
;;
(add-hook 'gtags-mode-hook
	  '(lambda ()
	     (setq gtags-pop-delete t)
	     (setq gtags-path-style 'absolute)
	     ))
;;
;; [Setting to make 'Gtags select mode' easy to see]
;;
(add-hook 'gtags-select-mode-hook
	  '(lambda ()
	     (setq hl-line-face 'underline)
	     (hl-line-mode 1)
	     ))
