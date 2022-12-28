;; Add your keys here, as such

;(global-set-key (kbd "[SHORTCUT]") '[FUNCTION])

(global-set-key (kbd "C-c C-o")
		(lambda () (interactive) (find-file "~/org/mw-tasks.org")))
(global-set-key (kbd "C-c C-c") 'org-capture)

; see base-functions.el for this function
(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

(provide 'base-global-keys)
