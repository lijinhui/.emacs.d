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

