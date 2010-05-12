(defun my-yasnippet-candidate-1 (table)
  (let ((hashtab (yas/snippet-table-hash table))
        (parent (if (fboundp 'yas/snippet-table-parent)
                    (yas/snippet-table-parent table)))
        candidates)
    (maphash (lambda (key value)
               (push key candidates))
             hashtab)
    ;;(setq candidates (all-completions ac-prefix (nreverse candidates)))
    (if parent
        (setq candidates
              (append candidates (ac-yasnippet-candidate-1 parent))))
    candidates))

;;;###autoload
(defun company-yasnippet (command &optional arg &rest ignored)
  (case command
    ('prefix (company-grab-symbol))
    ('candidates 
     (all-completions arg (apply 'append (mapcar 'my-yasnippet-candidate-1  (yas/get-snippet-tables major-mode))))
     ;;(apply 'append (mapcar 'my-yasnippet-candidate-1  (yas/get-snippet-tables major-mode)))
     )
    ('meta (format "Yasnippet %s" arg))
    )  
  )

(company-yasnippet 'prefix "all")
(provide 'company-yasnippet)

