;;------------basic edit settings-----------------------
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>")   'end-of-line)
(global-set-key (kbd "C-<home>") 'beginning-of-buffer)
(global-set-key (kbd "C-<end>") 'end-of-buffer)
(global-set-key [f11] 'my-fullscreen)
(global-set-key (kbd "C-c j") 'replace-regexp)
(global-set-key (kbd "C-c h l") 'hl-line-mode)

(print "end of basic edit settings")
;;-------------end of global key----------------------






;;-----------------------common settings--------------
(print "common settings")
;;在dired下通过a健打开文件
(put 'dired-find-alternate-file 'disabled nil)
(setq visible-bell t) ;;关闭烦人的出错时的提示声
(display-time-mode 1);;显示时间，格式如下
(setq display-time-24hr-format t);24小时制
(setq display-time-day-and-date t)
(global-font-lock-mode t);语法高亮
(show-paren-mode t);显示括号匹配
(setq column-number-mode t) ;显示列号
(setq line-number-mode t);显示行号
(fset 'yes-or-no-p 'y-or-n-p);;y,n代替yes or no
(setq inhibit-startup-message t);; disable the welcome screen
(setq gnus-inhibit-startup-message t);;去掉gnus启动时的引导界面
(setq default-fill-column 80) ;;for my wide screen
;; 让sentence-end可以识别全角的标点符号
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
(transient-mark-mode t);;高亮显示要拷贝的区域
(when (window-system)
  (tool-bar-mode -1);;调整工具条的模式(在不在顶栏显示工具栏图标) 1表示显示 -1表示不显示
)
(setq x-select-enable-clipboard t) ;支持emacs和外部程序的粘贴
(setq tab-width 4)
;;alt + arrow to switch windows
(windmove-default-keybindings 'meta)
;(windmove-default-keybindings 'super)

;;----------------------------------------------------------------------------
;; 默认进入auto-fill模式
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq frame-title-format "lijinhui    %b    %f");emacs窗体显示文字b表示buffer的名字,f表示文件的路径
(setq cursor-in-non-selected-windows nil)
(setq default-cursor-type 'box)
(if (functionp 'scroll-bar-mode)
    (scroll-bar-mode -1)
  )
;;(set-scroll-bar-mode 'left) ;;滚动条设在左侧
(setq show-paren-style 'mixed)
(auto-image-file-mode t);;打开图片功能
(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
;;----------------------------------------------------------------------------
;; 设置地理位置
(setq calendar-latitude 39.90)
(setq calendar-longitude 116.30)
(setq calendar-location-name "Beijing")
;; 在日历中使用天干地支
(setq chinese-calendar-celestial-stem
      ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
(setq chinese-calendar-terrestrial-branch
      ["子" "丑" "寅" "卯" "辰" "巳" "戊" "未" "申" "酉" "戌" "亥"])

(setq make-backup-files t)






;;;; grep find 

(when (eq system-type 'windows-nt)
  (setenv "PATH" (concat "d:/Program Files/GnuWin32/bin/;" (getenv "PATH") ) )
  (setq find-program "find")
  (setq grep-program "grep")
  (setq grep-find-use-xargs "gnu")
)









;------将c-s改为正则搜索-------
(global-set-key [(control s)] 'isearch-forward-regexp)
(global-set-key [(control r)] 'isearch-backward-regexp)
;; Always end searches at the beginning of the matching expression.
(add-hook 'isearch-mode-end-hook 'custom-goto-match-beginning)
(defun custom-goto-match-beginning ()
  "Use with isearch hook to end search at first char of match."
    (when isearch-forward (goto-char isearch-other-end)))

;; isearch at point
;; I-search with initial contents
(defvar isearch-initial-string nil)

(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))

(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
	   (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
	  (isearch-forward regexp-p no-recursive-edit)
	(setq isearch-initial-string (buffer-substring begin end))
	(add-hook 'isearch-mode-hook 'isearch-set-initial-string)
	(isearch-forward regexp-p no-recursive-edit)))))
  
 (global-set-key (kbd "C-c C-s") 'isearch-forward-at-point)











;-------自动补全括号--------
(setq skeleton-pair t)
(setq skeleton-pair-alist 
      '((?\( _ ")")
	       (?（ _ "）")
	       (?\[ _ "]")
        (?{ _ "}")
        (?\" _ "\"")))
        
( setq skeleton-pair-alist nil)

(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
;;(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
;(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)









;------没有选中区域时拷贝当前行-------------
(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
		   (line-beginning-position 2)))))

(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive   
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
   (line-beginning-position 2)))))


(defun my-append-to-org-bufer ()
  (interactive)
  (if mark-active 
      (progn
	(append-to-buffer "r.org" (region-beginning) (region-end))
	)
    (progn
      (append-to-buffer "r.org" (line-beginning-position) (line-beginning-position 2))
      (next-line)
    ))
  )

(defun my-append-newline-to-org-buffer ()
   (interactive)
   (with-current-buffer "r.org"
     (insert "\n")
     (message "inserted newline to org buffer")
       )
   )

(require 'info)
(define-key Info-mode-map (kbd "k") 'my-append-to-org-bufer)
(define-key Info-mode-map (kbd "o") 'my-append-newline-to-org-buffer)

(define-key Info-mode-map (kbd "j") 'next-line)
(define-key Info-mode-map (kbd "f") 'previous-line)


;;;;---rotate window - buffer
;;;;
(defun rotate-windows ()
  "Rotate your windows" (interactive) (cond ((not (> (count-windows) 1)) (message "You can't rotate a single window!"))
 (t
  (setq i 1)
  (setq numWindows (count-windows))
  (while  (< i numWindows)
    (let* (
           (w1 (elt (window-list) i))
           (w2 (elt (window-list) (+ (% i numWindows) 1)))
           (b1 (window-buffer w1))
           (b2 (window-buffer w2))
           (s1 (window-start w1))
           (s2 (window-start w2))
           )
      (set-window-buffer w1  b2)
      (set-window-buffer w2 b1)
      (set-window-start w1 s2)
      (set-window-start w2 s1)
      (setq i (1+ i)))))))


(global-set-key (kbd "C-M-j") 'rotate-windows)

 

(print "end of common set")
;-----end of common set----------








;;max frame
;;----------------------- -------------
;
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
)

;
(defun unix-maximized-horz ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(defun unix-maximized-vert ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
(defun unix-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))

(defun w32-restore-frame ()
"Restore a minimized frame"
(interactive)
(w32-send-sys-command 61728))

(defun w32-maximize-frame ()
"Maximize the current frame"
(interactive)
(w32-send-sys-command 61488))

(defun my-max-frame()
  (interactive)
  (when window-system
    (if (eq system-type 'windows-nt) (progn (w32-restore-frame)(w32-maximize-frame))
      (unix-maximized)))
  )

(my-max-frame)












;;--------------------行号-----------
(require 'linum)
(linum-mode)
(setq linum-format "%-4d")
;;(global-linum-mode)
;----------end of set line-number-mode






;;----------------interactive do thing--------------------------
;; emacs 自带
;;
;;http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
;;

(require 'ido)
(ido-mode t)
;;;;;-----------------end of ido-------------------





;;-------icomplete----------
(icomplete-mode 99)








;;----------------  ibuffer----------
;;comming with emacs
;;C-u C-x C-b
(print "ibuffer")
(require 'ibuffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("perl" (mode . cperl-mode))
	       ("erc" (mode . erc-mode))
	       ("c c++" (or
			 (mode . c-mode)
			 (mode . cc-mode)
			 (mode . c++-mode)))
	       ("java" (mode . java-mode))
	       ("planner" (or
			   (name . "^\\*Calendar\\*$")
			   (name . "^diary$")
			   (mode . muse-mode)))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")))
	       ("gnus" (or
			(mode . message-mode)
			(mode . bbdb-mode)
			(mode . mail-mode)
			(mode . gnus-group-mode)
			(mode . gnus-summary-mode)
			(mode . gnus-article-mode)
			(name . "^\\.bbdb$")
			(name . "^\\.newsrc-dribble")))))))

   ; (add-hook 'ibuffer-mode-hook
    ;          (lambda ()
     ;           (ibuffer-switch-to-saved-filter-groups "default")))


;;;;;sort by pathname
(print "end of ibuffer")
;------------------end of ibuffer---------------------
















;;-------------------browse kill ring------------------
;;comming with emacs
(print "kill ring")
(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
(setq kill-ring-max 60)
(print "end of kill ring")
;;-----------------end of kill ring---------







;;-----------------dired---------------------------------
(print "dired")

;; 这个命令可以在 windows 下用 X 调用系统的文件关联程序打开文件。
;; This allows "X" in dired to open the file using the explorer
;; settings. From TBABIN(at)nortelnetworks.com ToDo: adapt
;; mswindows-shell-execute() for XEmacs or use tinyurl shell exec
(when (and (string-match "GNU" (emacs-version))
           (string= window-system "w32"))

(defun dired-custom-execute-file (&optional arg)
    (interactive "P")
    (mapcar #'(lambda (file)
                (w32-shell-execute "open" (convert-standard-filename file)))
            (dired-get-marked-files nil arg)))

(defun dired-custom-explore-file (&optional arg)
    (interactive "P")
    (mapcar #'(lambda (file)
                (w32-shell-execute "explore" (convert-standard-filename file)))
            (dired-get-marked-files nil arg)))
(defun dired-custom-edit-file (&optional arg)
    (interactive "P")
    (mapcar #'(lambda (file)
                (w32-shell-execute "edit" (convert-standard-filename file)))
            (dired-get-marked-files nil arg)))
    
(defun dired-custom-dired-mode-hook ()
    (define-key dired-mode-map "X" 'dired-custom-execute-file)
    (define-key dired-mode-map "e" 'dired-custom-explore-file)
    (define-key dired-mode-map "E" 'dired-custom-edit-file)
    )
(add-hook 'dired-mode-hook 'dired-custom-dired-mode-hook))



(setq dired-recursive-deletes "top") ; 可以递归的删除目录
(setq dired-recursive-copies "top")  ; 可以递归的进行拷贝
(require 'dired-x)               ; 有些特殊的功能
(global-set-key "\C-x\C-j" 'dired-jump) ; 通过 C-x C-j 跳转到当前目录的 Dired
;parameters for ls
(setq dired-listing-switches "-lah")
(print dired-guess-shell-alist-default)
(setq dired-guess-shell-alist-user
      (list
       
       (list "\\.[rR][mM]\\(?:[vV][bB]\\)?" "smplayer * >/dev/null 2>&1 &")

      )
 ) ; 设置一些文件的默认打开方式，此功能必须在(require 'dired-x)之后
(print "end of dired")
;-------------end of dired---------------





;;;;-----------------图片查看thumbs
(autoload 'thumbs "thumbs" "Preview images in a directory." t)


;;--------------custom sets--------------







;; ;;;;--------smart tab----------
;; (require 'yasnippet)
;; (yas/initialize)

 
;; ;;;
;; ;; Smart Tab
;; ;; Taken from http://www.emacswiki.org/cgi-bin/wiki/TabCompletion
;; (global-set-key [(tab)] 'smart-tab)
;; (defvar smart-tab-completion-functions
;;   '((emacs-lisp-mode lisp-complete-symbol)
;;     (lisp-mode slime-complete-symbol)
;;     (python-mode rope-code-assist)
;;     (text-mode dabbrev-completion))
;;   "List of major modes in which to use a mode specific completion
;; function.")
 
;; (defun get-completion-function()
;;   "Get a completion function according to current major mode."
;;   (let ((completion-function
;;          (second (assq major-mode smart-tab-completion-functions))))
;;     (if (null completion-function)
;;         'dabbrev-completion
;;         completion-function)))
 
;; (defun smart-tab (prefix)
;;   "Needs `transient-mark-mode' to be on. This smart tab is
;; minibuffer compliant: it acts as usual in the minibuffer.
 
;; In all other buffers: if PREFIX is \\[universal-argument], calls
;; `smart-indent'. Else if point is at the end of a symbol,
;; expands it. Else calls `smart-indent'."
;;   (interactive "P")
;;   (if (minibufferp)
;;       (minibuffer-complete)
;;     (if (smart-tab-must-expand prefix)
;;         (let ((dabbrev-case-fold-search t)
;;               (dabbrev-case-replace nil))
;;           (funcall (get-completion-function))))
;;     (smart-indent)))
 
;; (defun smart-tab-must-expand (&optional prefix)
;;   "If PREFIX is \\[universal-argument], answers no.
;; Otherwise, analyses point position and answers."
;;   (unless (or (consp prefix)
;;               mark-active)
;;     (looking-at "\\_>")))
;; (defun smart-indent ()
;;   "Indents region if mark is active, or current line otherwise."
;;   (interactive)
;;   (if mark-active
;;       (indent-region (region-beginning)
;;                      (region-end))
;;     (indent-for-tab-command)))





;;;----------------------doc-view-----------
;;;gs for windows
;;;http://pages.cs.wisc.edu/~ghost/doc/GPL/gpl864.htm
(setq doc-view-ghostscript-program "C:\Program Files\gs\gs8.64\bin\gswin32c.exe")


;;;----------------end of doc-view----------

(setq ispell-program-name "C:\\Program Files\\Aspell\\bin\\aspell.exe")



;;;--------dic.cn
(defun lookup-dictcn (newword)
;  (interactive (thing-at-point 'word)))
;		  (if (equal nil word) "sLookup: " (format "sLookup (default %s)" word)) )
;	       )
  (interactive "sLookup:")
  (print newword)
  (if (or (equal nil newword) (equal "" newword)) (setq newword (thing-at-point 'word)))
  (if (not (equal nil newword))
      (browse-url (concat "www.dict.cn/mini.php?q=" newword ))
    (message "no word")
      ) 
)
(global-set-key (kbd "\C-c d") 'lookup-dictcn)


;;;;uniquiry
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)



;;;;;------alias
(defalias 'ib 'insert-buffer)

(defalias 'tro 'toggle-read-only)
(defalias 'rb 'revert-buffer)
(defalias 'bu 'browse-url)



;;;;;vist rst django doc

(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
		("\\.cs$" . c++-mode)
                ("\\.txt$" . rst-mode)) auto-mode-alist))

(setq django-doc-root "e:/software/django/docs/")
(defun find-rst-django-doc ()
  (interactive)
  (let ((doc (thing-at-point 'symbol)))
	(print doc)
	(set-text-properties 0 (length doc) nil doc)
	(print doc)
    (setq con nil)
    (when (string-match "<?\\(\\sw\\|-\\)+>?" doc)
      (setq doc (replace-in-string
		 (replace-in-string doc "<" "/") ">" ""))
	  (setq doc (concat doc ".txt"))
      (setq con t)
      
      )
    (while con
      (print doc)
      (when (file-exists-p (concat django-doc-root doc))
	(setq con nil)
	(find-file-read-only (concat django-doc-root doc))

	)
      (when con
	(setq index (string-match "-" doc))
	(if index
	    (setq doc (concat (substring doc 0 index) "/" (substring doc (1+ index) )))
	  (setq con nil)
	  )
	)
      )
    )

  )
(global-set-key (kbd "C-c p") 'find-rst-django-doc)
(setq )



;;;; insert duplicate lines 
;;;; copy from http://blog.tuxicity.se/elisp/emacs/2010/03/11/duplicate-current-line-or-region-in-emacs.html
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))


(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)




;;;;info dirs
(require 'info)
(add-to-list 'Info-default-directory-list "/home/lijinhui/info/")
(add-to-list 'Info-default-directory-list "/home/lijinhui/.emacs.d/ess/doc/")

(add-hook 'Info-mode-hook		; After Info-mode has started
        (lambda ()
	  (setq Info-additional-directory-list Info-default-directory-list)
	  ))



(require 'url)

(defvar google-search-maxlen 50
  "Maximum string length of search term.  This prevents you from accidentally
sending a five megabyte query string to Netscape.")

(defun google-it (search-string)
  "Search for SEARCH-STRING on google."
  (interactive "sSearch for: ")
  (browse-url (concat "http://www.google.com/search?client=emacs&q="
                      (url-hexify-string
                       (encode-coding-string search-string 'utf-8)))))

(defun google-search-selection ()
  "Create a Google search URL and send it to your web browser."
  (interactive)
  (let (start end term url)
    (if (or (not (fboundp 'region-exists-p)) (region-exists-p))
        (progn
          (setq start (region-beginning)
                end   (region-end))
          (if (> (- start end) google-search-maxlen)
              (setq term (buffer-substring start (+ start google-search-maxlen)))
            (setq term (buffer-substring start end)))
          (google-it term))
      (beep)
      (message "Region not active"))))
