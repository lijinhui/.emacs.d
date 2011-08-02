(setq my-db-servers '(
                      ("adgaga1" :host "db1" :user "adgaga" :password "adgaga" :db "adgaga")
                      ("adgaga2" :host "db2" :user "adgaga" :password "adgaga" :db "adgaga")
                      ("stat1"   :host "db1" :user "stat"   :password "stat"   :db "stat")
                      ("stat2"   :host "db2" :user "stat"   :password "stat"   :db "stat")
                      ("sogou"   :host "adgagadev"  :user "adgaga" :password "adgaga" :db "sogou")
                      
                      ))

(defun my-sql-get-login()
  (let ((db (ido-completing-read "connect:" (maplist  (lambda (x) (caar x)) my-db-servers)))
        )
    (message db)
    (setq my-select-db-config (cdr (assoc db my-db-servers)))
    (setq sql-server (plist-get my-select-db-config  :host) 
          sql-user (plist-get my-select-db-config  :user) 
          sql-password (plist-get my-select-db-config  :password) 
          sql-database (plist-get my-select-db-config  :db) )))


(defun my-mysql-connect ()
  (interactive)
  (setq product 'mysql)
  (setq sql-mysql-options (list "--default-character-set=utf8") )
  (when (sql-product-feature :sqli-connect product)
    (if (comint-check-proc "*SQL*")
	(pop-to-buffer "*SQL*")
      ;; Get credentials.
      ;;(apply 'sql-get-login (sql-product-feature :sqli-login product))
      (my-sql-get-login)
      ;; Connect to database.
      (message "Login...")
      ;;(funcall (sql-product-feature :sqli-connect product))
      (my-sql-connect-mysql)
      ;; Set SQLi mode.
      (setq sql-interactive-product product)
      (setq sql-buffer (current-buffer))
      (sql-interactive-mode)
      ;; All done.
      (message "Login...done")
      (pop-to-buffer sql-buffer)
      (sql-rename-buffer)
      )
    ))

(defun my-sql-connect-mysql ()
  "Create comint buffer and connect to MySQL using the login
parameters and command options."
  ;; Put all parameters to the program (if defined) in a list and call
  ;; make-comint.
  (let ((params))
    (message "---------")
    (message (mapconcat 'identity params " "))
    (if (not (string= "" sql-database))
	(setq params (append (list sql-database) params)))
    (if (not (string= "" sql-server))
	(setq params (append (list (concat "--host=" sql-server)) params)))
    (if (not (string= "" sql-password))
	(setq params (append (list (concat "--password=" sql-password)) params)))
    (if (not (string= "" sql-user))
	(setq params (append (list (concat "--user=" sql-user)) params)))
    (message (mapconcat 'identity params " "))

    (if (not (null sql-mysql-options))
	(setq params (append sql-mysql-options params)))
    (message (mapconcat 'identity params " "))
    (set-buffer (apply 'make-comint "SQL" sql-mysql-program
		       nil params))))

