;;; tricks modify origin funcs

(defun occur-read-primary-args ()
  (list (read-regexp "List lines matching regexp"
		     (if (thing-at-point 'symbol)
			 (substring-no-properties (thing-at-point 'symbol))
		       (car regexp-history)))
	(when current-prefix-arg
	  (prefix-numeric-value current-prefix-arg))))
