;; Nice icon set for emacs
(use-package all-the-icons)

;; Planet is a theme for Emacs inspired by the color palette of the former Gmail
;; theme, "Planets."
(use-package planet-theme
  :ensure t
  :config
  (load-theme 'planet t))

;; Mode-line variant
(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35)
  (setq doom-modeline-bar-width 1))

;; Font settings
(set-frame-font "IBM Plex Mono 13" t t)
;(set-frame-font "Victor Mono 13" t t)
;(set-frame-font "JetBrains Mono 12" t t)

;; Enable global visual-line-mode
(global-visual-line-mode t)

;; Turn on hl-line
(global-hl-line-mode 1)

;; Remove fringes left and right
(set-fringe-mode 0)

;; Enable line numbers
(global-display-line-numbers-mode 1)

;; Emacs 24.4 ships with a new minor mode called prettify-symbols-mode. Its purpose
;; is to replace the standard text representation of various identifiers/symbols with
;; a (arguably) more aesthetically pleasing representation (often a single unicode
;; character would replace several ascii characters).
(global-prettify-symbols-mode +1)

;; To keep syntax highlighting in the current line
(set-face-foreground 'highlight nil)

;; Set cursor color to bright yellow
(set-cursor-color "#FEFF00")

;; Set window frame size
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '(
              (width . 110) ; chars
              (height . 40))) ; lines
      (setq default-frame-alist
            '(
              (width . 110)
              (height . 40)))))


(provide 'base-theme)
