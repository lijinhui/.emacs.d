(defun hadoop-kill-current-job ()
  (interactive)
  (save-excursion
    (end-of-buffer)
    (search-backward-regexp "/usr/lib/.*/bin/hadoop job .* -kill \\([^ ]+\\)$")
    (setq kill-job-cmd (substring-no-properties (match-string 0)))
    (when (y-or-n-p kill-job-cmd)
      (shell-command kill-job-cmd)
      )
    )
  )
