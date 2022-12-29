;; Add your keys here, as such

;(global-set-key (kbd "[SHORTCUT]") '[FUNCTION])

(global-set-key (kbd "C-c C-o")
		(lambda () (interactive) (find-file "~/org/mw-tasks.org")))
(global-set-key (kbd "C-c C-c") 'org-capture)

;; Duplicate current line (or region)
(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

;; Reload the emacs configuration
(global-set-key (kbd "C-c <f12>") 'my-reload-emacs-configuration)

;; Prevent frame to be suspended (totally nerve-racking)
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))

(provide 'base-global-keys)
