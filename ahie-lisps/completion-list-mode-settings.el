;; -*- Emacs-Lisp -*-

;; Time-stamp: <10/25/2009 22:06:35 ������ by ahei>

;; Ϊ`completion-mode'����vi�İ���
(define-key completion-list-mode-map (kbd "SPC") 'scroll-up)
(define-key completion-list-mode-map (kbd "u") 'scroll-down)
(define-key completion-list-mode-map (kbd "n") 'next-completion)
(define-key completion-list-mode-map (kbd "p") 'previous-completion)
(define-key completion-list-mode-map (kbd "<") 'beginning-of-buffer)
(define-key completion-list-mode-map (kbd ">") 'end-of-buffer)
(define-key completion-list-mode-map (kbd ".") 'set-mark-command)
(define-key completion-list-mode-map (kbd "L") 'count-brf-lines)
