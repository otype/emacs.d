;; A utility package to collect various Icon Fonts and propertize them within Emacs.
;; https://github.com/domtronn/all-the-icons.el
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

;; A fancy and fast mode-line inspired by minimalism design.
;; https://github.com/seagle0128/doom-modeline
(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35)
  (setq doom-modeline-bar-width 1))

;; Highly accessible themes, conforming with the highest standard for colour
;; contrast between background and foreground values (WCAG AAA). They also are
;; optimised for users with red-green colour deficiency.
(use-package modus-themes
  :ensure t
  :demand t
  :init
  ;; Starting with version 5.0.0 of the `modus-themes', other packages
  ;; can be built on top to provide their own "Modus" derivatives.
  ;; For example, this is what I do with my `ef-themes' and
  ;; `standard-themes' (starting with versions 2.0.0 and 3.0.0,
  ;; respectively).
  ;;
  ;; The `modus-themes-include-derivatives-mode' makes all Modus
  ;; commands that act on a theme consider all such derivatives, if
  ;; their respective packages are available and have been loaded.
  ;;
  ;; Note that those packages can even completely take over from the
  ;; Modus themes such that, for example, `modus-themes-rotate' only
  ;; goes through the Ef themes (to this end, the Ef themes provide
  ;; the `ef-themes-take-over-modus-themes-mode' and the Standard
  ;; themes have the `standard-themes-take-over-modus-themes-mode'
  ;; equivalent).
  ;;
  ;; If you only care about the Modus themes, then (i) you do not need
  ;; to enable the `modus-themes-include-derivatives-mode' and (ii) do
  ;; not install and activate those other theme packages.
  (modus-themes-include-derivatives-mode 1)
  :bind
  (("<f5>" . modus-themes-rotate)
   ("C-<f5>" . modus-themes-select)
   ("M-<f5>" . modus-themes-load-random))
  :config
  ;; Your customizations here.  All customizations must evaluated
  ;; BEFORE loading the theme.
  (setq modus-themes-to-toggle '(modus-operandi modus-vivendi)
        modus-themes-to-rotate modus-themes-items
        modus-themes-mixed-fonts t
        modus-themes-variable-pitch-ui t
        modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-completions '((t . (bold)))
        modus-themes-prompts '(bold)
        modus-themes-headings
        '((agenda-structure . (variable-pitch light 2.2))
          (agenda-date . (variable-pitch regular 1.3))
          (t . (regular 1.15))))

  (setq modus-themes-common-palette-overrides nil)

  ;; Finally, load your theme of choice (or a random one with
  ;; `modus-themes-load-random', `modus-themes-load-random-dark',
  ;; `modus-themes-load-random-light').
  (modus-themes-load-theme 'modus-operandi))

;; Font settings
(set-frame-font "IBM Plex Mono 13" t)

;; Set Window/frame height and width
(if (window-system)
    (progn
      (set-frame-height (selected-frame) 35)
      (set-frame-width (selected-frame) 120)))

;; Enable global visual-line-mode
(global-visual-line-mode t)

;; Turn on hl-line
(global-hl-line-mode 1)

;; Enable line numbers
(global-display-line-numbers-mode 1)

;; Disable toolbar & menubar
(menu-bar-mode -1)

;; Disable the display of tool bars
(tool-bar-mode -1)

;; Disable the display of scroll bars
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
