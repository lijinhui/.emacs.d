(add-to-list 'load-path "~/.emacs.d/tree/")
(eval-after-load "tree-widget"
  '(if (boundp 'tree-widget-themes-load-path)
       (add-to-list 'tree-widget-themes-load-path "~/.emacs.d/tree/tree-widget")))

(require 'tree-mode)
(autoload 'imenu-tree "imenu-tree" "Imenu tree" t)
(autoload 'tags-tree "tags-tree" "TAGS tree" t)

(require 'wid-edit)
(defun follow-widget-button-not-jump ()
  "thisandthat."
  (interactive)
  (widget-button-press (point))
  ;;(imenu-tree)
  (unless (string= (buffer-name (current-buffer)) "*imenu-tree*")
    
    (switch-to-buffer-other-window (get-buffer-create "*imenu-tree*")))
  )
;;(define-key tree-mode-map  (kbd "f") 'widget-button-press)
(define-key tree-mode-map  (kbd "f") 'follow-widget-button-not-jump)
