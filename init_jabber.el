(add-to-list 'load-path "~/.emacs.d/emacs-jabber-0.8.0/")
(require 'jabber)
(setq jabber-account-list
      '(
	("lijinhui235711@gmail.com" 
	 (:network-server . "talk.google.com")
	 (:connection-type . ssl))
      
	("jinhui.li@langtaojin.com" 
	 (:network-server . "talk.google.com")
	 (:connection-type . ssl)))
      )
