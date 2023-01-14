;; Nice icon set for emacs
(use-package all-the-icons)

;; This projects aims to become an aesthetic, functional and efficient tabs plugin for
;; Emacs with a lot of customization options.
;; https://github.com/ema2159/centaur-tabs
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style      "rounded")
  (setq centaur-tabs-set-icons  t)
  (setq centaur-tabs-height     32)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>"  . centaur-tabs-forward))

;; Mode-line variant
(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35)
  (setq doom-modeline-bar-width 1))

;; Kaolin is a set of eye pleasing themes for GNU Emacs with support for a large
;; number of modes and external packages.
;; https://github.com/ogdenwebb/emacs-kaolin-themes
(use-package kaolin-themes
  :config
  (load-theme 'kaolin-shiva t)
  (kaolin-treemacs-theme))

;; Font settings
(set-frame-font "IBM Plex Mono 13" t)

;; Enable global visual-line-mode
(global-visual-line-mode t)

;; Turn on hl-line
(global-hl-line-mode 1)

;; Enable line numbers
(global-display-line-numbers-mode 1)

;; Disable toolbar & menubar
(menu-bar-mode -1)

;; Disable the display of tool bars
;; (when (fboundp 'tool-bar-mode)
;;   (tool-bar-mode -1))
(tool-bar-mode -1)

;; Disable the display of scroll bars
;; (when (fboundp 'scroll-bar-mode)
;;   (scroll-bar-mode -1))
(scroll-bar-mode -1)

;; show-paren-mode allows one to see matching pairs of parentheses and other characters.
;; When point is on the opening character of one of the paired characters, the other is
;; highlighted. When the point is after the closing character of one of the paired
;; characters, the other is highlighted.
(show-paren-mode 1)

;; disable splash screen
(setq inhibit-startup-message t)

;; The fringes normally appear between the display margins and the window text. If the
;; value is non-nil, they appear outside the display margins.
;;(setq fringes-outside-margins t)

;; Remove fringes left and right
(set-fringe-mode 5)

;; Emacs 24.4 ships with a new minor mode called prettify-symbols-mode. Its purpose
;; is to replace the standard text representation of various identifiers/symbols with
;; a (arguably) more aesthetically pleasing representation (often a single unicode
;; character would replace several ascii characters).
(global-prettify-symbols-mode +1)

;; To keep syntax highlighting in the current line
(set-face-foreground 'highlight nil)

;; Set cursor color to bright yellow
(set-cursor-color "#FEFF00")

;; Modify region background and text color
(set-face-attribute 'region nil :background "#FBFFC8")

(provide 'base-theme)
