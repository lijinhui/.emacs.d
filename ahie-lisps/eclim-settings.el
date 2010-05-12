;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-02-22 21:25:16 Monday by ahei>

(ignore-errors (require 'eclim))

(setq eclim-auto-save t)

(dolist (hook (list 'c-mode-common-hook 'lisp-mode-hook 'emacs-lisp-mode-hook 'java-mode-hook))
  (add-hook hook 'eclim-mode))
