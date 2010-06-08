(setq load-path (cons "~/.emacs.d/org-6.33f/lisp" load-path))
(setq load-path (cons "~/.emacs.d/org-6.33f/contrib/lisp" load-path))
(require 'org-install)
(defun my-org-mode-hook()
  (auto-fill-mode -1)
  )
(add-hook 'org-mode-hook 'my-org-mode-hook)
(setq org-agenda-files (list "~/org/work.org"
;; 			     "~/org/sparetime.org"
;; 			     "~/org/home.org"
;; 			     "~/org/fortune.org"
			     ))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(define-key org-mode-map (kbd "C-c m") 'org-time-stamp)


(setq org-log-done '(done)) 
(org-agenda-list)
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("laptop" . ?l) ("startup" . ?s) ("WeekPlan" . ?p) ("DayPlan" . ?d)))
(setq org-todo-keywords (quote ((sequence "TODO(t)" "STARTED(s!)" "|" "DONE(d!/!)")
 (sequence "WAITING(w@/!)" "SOMEDAY(S!)" "OPEN(O@)" "|" "CANCELLED(c@/!)")
 (sequence "QUOTE(q!)" "QUOTED(Q!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)"))))

(setq org-todo-keyword-faces (quote (("TODO" :foreground "red" :weight bold)
 ("STARTED" :foreground "blue" :weight bold)
 ("DONE" :foreground "forest green" :weight bold)
 ("WAITING" :foreground "orange" :weight bold)
 ("SOMEDAY" :foreground "magenta" :weight bold)
 ("CANCELLED" :foreground "forest green" :weight bold)
 ("QUOTE" :foreground "red" :weight bold)
 ("QUOTED" :foreground "magenta" :weight bold)
 ("APPROVED" :foreground "forest green" :weight bold)
 ("EXPIRED" :foreground "forest green" :weight bold)
 ("REJECTED" :foreground "forest green" :weight bold)
 ("OPEN" :foreground "blue" :weight bold))))
