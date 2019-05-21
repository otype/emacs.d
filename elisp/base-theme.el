(use-package powerline
  :ensure t
  :config
  (setq powerline-default-separator 'utf-8))

(use-package moe-theme
  :ensure t
  :config
  (moe-theme-set-color 'yellow)
  (powerline-moe-theme)
  (moe-dark))

;; Font settings
(set-frame-font "Monaco 13")

;; HIGHLIGHTING
;; Turn on hl-line
(global-hl-line-mode 1)

;;Set any color as the background face of the current line
(set-face-background 'hl-line "#3e4446")

;; To keep syntax highlighting in the current line
(set-face-foreground 'highlight nil)

;; Set cursor color to bright yellow
(set-cursor-color "#FEFF00")

(provide 'base-theme)
