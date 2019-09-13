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
;;(set-frame-font "Monaco 13" t t)
(set-frame-font "IBM Plex Mono 14" t t)

;; HIGHLIGHTING
;; Turn on hl-line
(global-hl-line-mode 1)

;; Emacs 24.4 ships with a new minor mode called prettify-symbols-mode. Its purpose
;; is to replace the standard text representation of various identifiers/symbols with
;; a (arguably) more aesthetically pleasing representation (often a single unicode
;; character would replace several ascii characters).
(global-prettify-symbols-mode +1)

;;Set any color as the background face of the current line
(set-face-background 'hl-line "#3e4446")

;; To keep syntax highlighting in the current line
(set-face-foreground 'highlight nil)

;; Set cursor color to bright yellow
(set-cursor-color "#FEFF00")

;; Set window frame size
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '(
              (width . 150) ; chars
              (height . 70))) ; lines
      (setq default-frame-alist
            '(
              (width . 150)
              (height . 70)))))


(provide 'base-theme)
