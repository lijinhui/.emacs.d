(require 'magit)
(defun magit-read-create-branch-args ()
  "create new branch with time prefix"
  (let* ((cur-branch (magit-get-current-branch))
         (branch (read-string "Create branch: " (format-time-string "%Y_%m_%d.%H.%M__")))
         (parent (magit-read-rev "Parent" cur-branch)))
    (list branch parent)))
