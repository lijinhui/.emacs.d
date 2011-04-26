(setq gnus-select-method '(nntp "news.yaako.com")
(setq gnus-secondary-select-methods 
'(
  (nntp "news.newsfan.net")))
      ;; 这些是其他的。
      gnus-secondary-select-methods
      '(
	;;(nnml "private") ;; 这个是本地邮件
	(nntp "news.newsfan.net") ;; 新帆
	;;(nntp "news.cnnb.net") ;; 宁波
	))



(setq gnus-default-subscribed-newsgroups
        '("gnu.emacs.help"
        "gnu.emacs.sources"))
