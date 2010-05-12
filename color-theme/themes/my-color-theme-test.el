(eval-when-compile
  (require 'color-theme))

(defun color-theme-example ()
  "Example theme. Carbon copy of color-theme-gnome contributed by Jonadab."
  (interactive)
  (color-theme-install
   '(color-theme-example
     ((foreground-color . "wheat")
      ;(background-color . "darkslategrey")
      )
     
     )))
