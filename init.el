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

;;(load-file "~/.emacs.d/init_company.el")
(load-file "~/.emacs.d/init_session.el")

(load-file "~/.emacs.d/init_org.el")
;;(add-to-list 'load-path "~/.emacs.d/company")

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
(load-file "~/.emacs.d/init_tree.el")



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
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(which-func ((((class color) (min-colors 88) (background dark)) (:foreground "pink")))))
