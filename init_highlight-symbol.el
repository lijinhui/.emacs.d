(setq highlight-symbol-idle-delay 1.5)

(require 'highlight-symbol)
(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)
(add-hook 'cc-mode-hook 'highlight-symbol-mode)
