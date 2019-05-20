;; Font settings
(set-frame-font "Monaco 13")

(use-package farmhouse-theme
  :ensure t
  :load-path "~/.emacs.d/elpa/farmhouse-theme-20160713.2244"
  :defer t
  :init
  (load-theme 'farmhouse-dark t))

(use-package powerline
  :ensure t
  :init
  (powerline-center-theme)
  (setq powerline-default-separator 'utf-8))

(provide 'base-theme)
