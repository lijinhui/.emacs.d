(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      '(("default"
	 ("magit" (name . "\*magit.*"))
	 ("dired" (mode . dired-mode))
	 ("org" (mode . org-mode))
	 ("shell" (or 
		   (mode . shell-mode)
		   (name . "\*Python\*")
		   (name . "\*eshell\*")
		   (mode . term-mode)
		   ))
	 ("sem_stats" (filename . ".*/jcnmining/sem_stats/.*"))
	 ("log2session" (filename . ".*/jcnmining/log2session_mapred/.*"))
	 ("jcnmining" (filename . ".*/jcnmining/.*"))
	 ("python" (mode . python-mode))
	 ("elisp" (filename . ".*\.el$"))
	 ("special" (name . "\*.*\*"))
	 )
	)
      )

(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-switch-to-saved-filter-groups "default")
	    ))

(defun ibuffer-split-list (ibuffer-split-list-fn ibuffer-split-list-elts)
  (let ((hip-crowd nil)
	(lamers nil))
    (dolist (ibuffer-split-list-elt ibuffer-split-list-elts)
      (progn
	(if (funcall ibuffer-split-list-fn ibuffer-split-list-elt)
	    (push ibuffer-split-list-elt hip-crowd))
	(print ibuffer-split-list-fn)
	(push ibuffer-split-list-elt lamers)
	))
    ;; Too bad Emacs Lisp doesn't have multiple values.
    (list (nreverse hip-crowd) (nreverse lamers))))




;;;;;;    (defun ibuffer-generate-filter-groups (bmarklist &optional noempty nodefault)
;;;;;;      (let ((filter-group-alist (if nodefault
;;;;;;    				ibuffer-filter-groups
;;;;;;    			      (append ibuffer-filter-groups
;;;;;;    				      (list (cons "Default" nil))))))
;;;;;;        (let ((vec (make-vector (length filter-group-alist) nil))
;;;;;;    	  (i 0))
;;;;;;          (dolist (filtergroup filter-group-alist)
;;;;;;    	(let ((filterset (cdr filtergroup)))
;;;;;;    	  (multiple-value-bind (hip-crowd lamers)
;;;;;;    	      (values-list
;;;;;;    	       (ibuffer-split-list (lambda (bufmark)
;;;;;;    				     (ibuffer-included-in-filters-p (car bufmark)
;;;;;;    								    filterset))
;;;;;;    				   bmarklist))
;;;;;;    	    (aset vec i hip-crowd)
;;;;;;    	    (incf i)
;;;;;;    	    (setq bmarklist lamers))))
;;;;;;          (let (ret)
;;;;;;    	(dotimes (j i ret)
;;;;;;    	  (let ((bufs (aref vec j)))
;;;;;;    	    (unless (and noempty (null bufs))
;;;;;;    	      (push (cons (car (nth j filter-group-alist))
;;;;;;    			  bufs)
;;;;;;    		    ret))))))))
