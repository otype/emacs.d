;; Add your keys here, as such

;(global-set-key (kbd "[SHORTCUT]") '[FUNCTION])

(global-set-key (kbd "C-c o")
		(lambda () (interactive) (find-file "~/org/mw-tasks.org")))
(global-set-key (kbd "C-c c") 'org-capture)

(provide 'base-global-keys)
