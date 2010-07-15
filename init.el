(require 'ido)
(require 'ibuffer)
(ido-mode t)
(tool-bar-mode -1)

(put 'dired-find-alternate-file 'disabled nil)
(add-to-list 'load-path "~/.emacs.d/els")
(require 'emacsd-tile)
(require 'drag-stuff)
(load-file "~/.emacs.d/init_color-theme.el")
(load-file "~/.emacs.d/init_highlight-symbol.el")
(load-file "~/.emacs.d/init_basic.el")
(load-file "~/.emacs.d/init_auto-complete.el")
(load-file "~/.emacs.d/init_ack.el")
(load-file "~/.emacs.d/init_cedet.el")
(load-file "~/.emacs.d/init_python.el")

;;(load-file "~/.emacs.d/init_company.el")
(load-file "~/.emacs.d/init_session.el")

(load-file "~/.emacs.d/init_org.el")
;;(add-to-list 'load-path "~/.emacs.d/company")

;;;default font


(defun fontify-frame (frame)
  (set-frame-parameter frame 'font "Monospace-12")
)
(push 'fontify-frame after-make-frame-functions)

;;;;---------打开文件时只读
(defun my-find-file-exist-view-mode ()
  (interactive)
  (when (file-exists-p (buffer-file-name)) (view-mode))
  )
(eval-after-load "view"
  '(let ((map view-mode-map))
     (define-key map "h" 'backward-char)
     (define-key map "l" 'forward-char)
     (define-key map "j" 'next-line)
     (define-key map "k" 'previous-line))
  )
(add-hook 'find-file-hook 'my-find-file-exist-view-mode)



;;;tree
;;(load-file "~/.emacs.d/init_tree.el")


;;;tabbar
;(require 'tabbar)
;(tabbar-mode)
;(global-set-key (kbd "C-x C-n") 'tabbar-forward-tab)
;(global-set-key (kbd "C-x C-p") 'tabbar-backward-tab)


;;;;multi-term

(require 'multi-term)


;;;; WARNING: This method will make emacsclient can't start up
;;;; use whitespace-mode instead
;;;;(defun my-font-lock-mode-hook()
;;;;  (setq font-lock-keywords
;;;;	(append font-lock-keywords
;;;;		   '(("\t+" (0 'my-tab-face t))
;;;;                 ("^.\\{101,\\}$" (0 'my-long-line-face t))
;;;;                 ("[ \t]+$"      (0 'my-trailing-space-face t))))))
;;;;
;;;;
;;;;(add-hook 'font-lock-mode-hook 'my-font-lock-mode-hook)


;;whitespace-mode
;;lines-tail 只标识长度超过配置长度的部分
(setq whitespace-style  '(tabs tab-mark trailing lines-tail ))
(setq whitespace-tab 'whitespace-line)
(global-whitespace-mode)





;;; seting gbk
;;(set-terminal-coding-system 'chinese-gbk)
;;(set-keyboard-coding-system 'chinese-gbk)
;;(set-language-environment 'chinese-gbk)
;;(set-clipboard-coding-system 'chinese-gbk)
;;(set-selection-coding-system 'chinese-gbk)
;;(setq locale-coding-system 'chinese-gbk)
;;(setq current-language-environment "Chinese-GBK")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(ecb-layout-window-sizes (quote (("leftright-analyse" (ecb-directories-buffer-name 0.12666666666666668 . 0.3902439024390244) (ecb-sources-buffer-name 0.12666666666666668 . 0.2926829268292683) (ecb-history-buffer-name 0.12666666666666668 . 0.2926829268292683) (ecb-methods-buffer-name 0.14 . 0.6097560975609756) (ecb-analyse-buffer-name 0.14 . 0.36585365853658536)))))
 '(show-paren-mode t)
 '(tabbar-mode t))

