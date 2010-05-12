;; -*- Emacs-Lisp -*-

;; Time-stamp: <2009-11-13 22:20:32 Friday by ahei>

(require 'perl-mode)
(require 'cperl-mode)
(require 'shell)
(require 'fortran)
(if (not is-before-emacs-21) (require 'python))
(require 'message)
(require 'sgml-mode)
(require 'ruby-mode)

(require 'my-msf-abbrev)
(require 'conf-mode)
(setq msf-abbrev-root (concat my-emacs-path "mode-abbrevs"))
(dolist (map (list c-mode-base-map emacs-lisp-mode-map sh-mode-map ruby-mode-map
                   conf-javaprop-mode-map sgml-mode-map))
  (define-key map (kbd "C-c R") 'msf-abbrev-goto-root)
  (define-key map (kbd "C-c A") 'msf-abbrev-define-new-abbrev-this-mode))
(msf-abbrev-load)

(defun complete-or-indent (arg &optional is-lisp command)
  "�������ڵ��ʺ���Ͳ���,�������indent.IS-LISPΪt��ʱ������`PC-lisp-complete-symbol'"
  (interactive "P")
  (if mark-active
      (indent-region (region-beginning) (region-end))
    (if (looking-at "\\>")
        (if is-lisp (PC-lisp-complete-symbol) (hippie-expand arg))
      (if command
          (call-interactively command)
        (indent-for-tab-command)))))

(defun cond-fld-prev ()
  "�����snippet��map��,��ִ��`fld-prev',����ʲô������"
  (interactive)
  (if (fld-exit)
      (fld-prev)))

(if is-before-emacs-21
    (progn
      (defun fld-next-or-complete-or-indent (arg &optional is-lisp)
        "�����snippet��map��,��ִ��fld-next,����ִ��complete-or-indent"
        (interactive)
        (if (fld-exit)
            (fld-next)
          (complete-or-indent arg is-lisp)))

      (defun cond-fld-choose ()
        "�����snippet��map��,��ִ��fld-choose,����ִ��c-context-line-break"
        (interactive)
        (if (fld-exit)
            (fld-choose)
          (c-context-line-break)))

      (define-key c-mode-base-map (kbd "RET") 'cond-fld-choose)
      (add-hook 'c++-mode-hook (lambda () (define-key c++-mode-map (kbd "RET") 'cond-fld-choose)) t)
      (define-key c-mode-base-map (kbd "M-RET") 'fld-cleanup-form-at-point))

  (defun complete-or-indent-for-lisp ()
    "`lisp-mode'�µ�`complete-or-indent'"
    (interactive)
    (complete-or-indent nil t)))
(define-key c-mode-base-map (kbd "<backtab>") 'cond-fld-prev)
