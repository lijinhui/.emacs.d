;; -*- Emacs-Lisp -*-

;; Time-stamp: <10/23/2009 23:57:12 ������ by ahei>

;; Ϊ`Man-mode'����vi�İ���
(define-key Man-mode-map "Q" 'Man-kill)
(define-key Man-mode-map "u" 'scroll-down)
(define-key Man-mode-map "." 'set-mark-command)
(define-key Man-mode-map "'" 'switch-to-other-buffer)
(define-key global-map (kbd "C-x M") 'woman)

(dolist (map (list c-mode-base-map sh-mode-map))
  (define-key map (kbd "C-c /") 'man-current-word))
(defun man-current-word ()
  "�鿴��ǰ������ڵĴʵ�`man'"
  (interactive)
  (manual-entry (current-word)))

(load "woman-settings")
