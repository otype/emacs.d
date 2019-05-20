(use-package farmhouse-theme
  :ensure t
  :load-path "~/.emacs.d/elpa/farmhouse-theme-20160713.2244"
  :defer t
  :init
  (load-theme 'farmhouse-dark t))

;; (use-package moe-theme
;;   :ensure t
;;   :defer t)

(use-package powerline
  :ensure t
  :init
  (powerline-center-theme)
  (setq powerline-default-separator 'utf-8)
  )

;; (require 'moe-theme)
;; (setq moe-theme-highlight-buffer-id t)
;; (moe-theme-set-color 'blue)
;; (powerline-moe-theme)
;; (moe-dark)

(provide 'base-theme)
