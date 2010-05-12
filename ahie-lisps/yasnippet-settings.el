;; -*- Emacs-Lisp -*-

;; Time-stamp: <11/01/2009 18:37:35 ������ by ahei>

(require 'yasnippet)

(setq yas/root-directory (concat my-emacs-path "snippets"))
(yas/load-directory yas/root-directory)
(setq yas/trigger-key nil)
(yas/global-mode t)

(define-key yas/keymap (kbd "M-j") 'yas/next-field-or-maybe-expand)
(define-key yas/keymap (kbd "M-k") 'yas/prev-field)
