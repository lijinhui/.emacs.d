;;外观初始化配置：
;;color-theme
;;font
;;frame-max


;;---------外观-----------------
;;界面颜色主题 color-theme 6.6
;;下载网址：http://download.gna.org/color-theme/
(print "set color-theme")
(add-to-list 'load-path (concat "~/.emacs.d/" "color-theme"))

(require 'color-theme)
;;(require 'color-theme-autoloads)
(color-theme-initialize)
(color-theme-dark-blue2)
(if window-system
    (color-theme-deep-blue)
)
;;(color-theme-comidia)
;;(set-face-background 'default "LightCyan3") ;;设置背景色为 浅青色3


(defun my-color-theme-example ()
  "Example theme. Carbon copy of color-theme-gnome contributed by Jonadab."
  (interactive)
  (color-theme-install
   '(color-theme-example
     (
      (foreground-color . "lightblue")
      )

     (dired-directory ((t (:italic t :bold t :weight bold :slant italic :foreground "LightSkyBlue"))))
     (dired-face-boring ((t (:foreground "Gray65"))))
     (dired-face-directory ((t (:bold t :weight bold))))
     (dired-face-executable ((t (:foreground "gray85"))))
     (dired-face-flagged ((t (:background "LightSlateGray"))))
     (dired-face-header ((t (:background "grey75" :foreground "gray30"))))
     (dired-face-marked ((t (:background "PaleVioletRed"))))
     (dired-face-permissions ((t (:background "grey75" :foreground "gray30"))))
     (dired-face-setuid ((t (:foreground "gray85"))))
     (dired-face-socket ((t (:foreground "gray85"))))
     (dired-face-symlink ((t (:foreground "cyan"))))
     (dired-flagged ((t (:bold t :weight bold :foreground "Salmon"))))
     (dired-header ((t (:bold t :weight bold :foreground "PaleGreen"))))
     (dired-ignored ((t (:foreground "grey70"))))
     (dired-mark ((t (:bold t :weight bold :foreground "Aquamarine"))))
     (dired-marked ((t (:bold t :weight bold :foreground "Salmon"))))
     (dired-symlink ((t (:bold t :weight bold :foreground "Cyan"))))
     (dired-warning ((t (:italic t :slant italic :foreground "medium aquamarine"))))
          
           
     )))
;;(my-color-theme-example)
(print "end of set color-theme")
;
;-------   end of color-theme set---------
