(add-to-list 'load-path "~/.emacs.d/scala-mode/")
(require 'scala-mode-auto)

(add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(setq ac-candidate-limit 500)