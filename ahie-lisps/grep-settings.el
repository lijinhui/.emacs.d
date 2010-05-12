;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-03-02 13:53:18 Tuesday by ahei>

(require 'grep)

(defun find-grep-in-dir (dir)
  "Run `find-grep' in directory DIR."
  (interactive (list (read-directory-name "Directory to find in: " default-directory "" t)))
  (let ((prompt (concat "find " dir " -type f ! -wholename \"*/.svn*\" ! -wholename \"*~\" -print0 | xargs -0 -e grep -nH -e ")))
    (if is-after-emacs-23
        (grep-apply-setting 'grep-find-command prompt)
      (setq grep-find-command prompt))
    (call-interactively 'find-grep)))

(unless is-before-emacs-21
  (apply-define-key
   global-map
   `(("C-x F" find-grep)
     ("C-x f" find-grep-in-dir)))
  (apply-define-key
   grep-mode-map
   `(("q" bury-buffer)
     ("Q" kill-this-buffer)
     ("u" scroll-down)
     ("/" describe-symbol-at-point)
     ("t" sb-toggle-keep-buffer)
     ("N" select-buffer-forward)
     ("P" select-buffer-backward)
     ("L" count-brf-lines))))

(defvar grep-find-prompt "find . -type f ! -wholename \"*/.svn*\" ! -wholename \"*~\" -print0 | xargs -0 -e grep -nH -e "
  "*Default prompt of `grep-find'.")

(if is-after-emacs-23
    (grep-apply-setting 'grep-find-command grep-find-prompt)
  (setq grep-find-command grep-find-prompt))

(defvar grep-ignore-case nil "When run `grep' ignore case or not.")

(when grep-ignore-case
  (if is-after-emacs-23
      (grep-apply-setting 'grep-command "grep -inH -e ")
    (setq grep-command "grep -inH -e ")))

(defun grep-current-word (dir &optional is-prompt)
  "Run `grep' to find current word in directory DIR."
  (interactive
   (list
    (read-directory-name "Directory to grep in: " default-directory "" t)
    current-prefix-arg))
  (let* ((word (grep-tag-default))
         (commands (concat grep-command word " " dir "/*")))
    (if is-prompt
        (grep (read-shell-command "Run grep (like this): " commands 'grep-history))
        (grep commands))))

(defun grep-current-word-in-current-dir (&optional is-prompt)
  "Run `grep' to find current word in directory DIR."
  (interactive "P")
  (grep-current-word default-directory is-prompt))
