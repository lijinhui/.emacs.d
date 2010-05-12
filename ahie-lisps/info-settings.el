;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-02-04 14:58:18 Thursday by ahei>

(require 'info)

(apply-define-key
 Info-mode-map
 `(("j"     next-line)
   ("k"     previous-line)
   ("h"     backward-char)
   ("l"     forward-char)
   ("/"     describe-symbol-at-point)
   ("U"     Info-up)
   ("u"     View-scroll-half-page-backward)
   ("Q"     kill-this-buffer)
   ("o"     other-window)
   ("SPC"   scroll-up)
   ("C-h"   Info-up)
   ("N"     Info-next-reference)
   ("P"     Info-prev-reference)
   ("'"     switch-to-other-buffer)
   ("C-c ," Info-history-back)
   ("C-c ." Info-history-forward)))

(apply-args-list-to-fun
 'def-command-max-window
 `("info"))

(apply-define-key
 global-map
 `(("C-x I" info-max-window)))
