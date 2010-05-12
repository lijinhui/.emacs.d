;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-01-31 14:06:47 Sunday by ahei>

(require 'autopair)

;; After do this, isearch any string, M-: (match-data) always return (0 3)
(autopair-global-mode 1)

(setq autopair-extra-pairs `(:everywhere ((?` . ?'))))

(defun autopair-insert-opening-internal ()
  (interactive)
  (when (autopair-pair-p)
    (setq autopair-action (list 'opening (autopair-find-pair last-input-event) (point))))
  (autopair-fallback))

(defun autopair-insert-opening ()
  (interactive)
  (if (and (memq major-mode '(c-mode c++-mode java-mode)) (equal last-command-event ?{))
      (call-interactively 'skeleton-c-mode-left-brace)
    (call-interactively 'autopair-insert-opening-internal)))

(apply-define-key
 global-map
 `(("C-h" delete-backward-char)))
