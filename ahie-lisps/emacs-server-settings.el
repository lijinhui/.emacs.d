;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-02-25 14:07:15 Thursday by ahei>

(if is-before-emacs-21
    (progn
      ;; gnuserv
      (require 'gnuserv-compat)
      (gnuserv-start)
      ;; 在当前frame打开
      (setq gnuserv-frame (selected-frame))
      ;; 打开后让emacs跳到前面来
      (setenv "GNUSERV_SHOW_EMACS" "1"))
  (if is-after-emacs-23
      (server-force-delete))
  (server-start))
