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

;; Follow the current Omarchy theme. Only the colors are taken over from the
;; Omarchy Emacs integration (/usr/share/omarchy-emacs); fonts and the rest of
;; its setup are deliberately left out.
(require 'cl-lib)
(require 'filenotify)

(defvar omarchy-current-dir
  (cl-find-if (lambda (d) (file-directory-p (expand-file-name "theme" d)))
              '("~/.local/state/omarchy/current" ; Omarchy 4
                "~/.config/omarchy/current"))     ; Omarchy 3
  "Directory holding Omarchy's current theme assets.")

(defun omarchy-apply-theme ()
  "Load the colors of the current Omarchy theme as the `omarchy' Emacs theme."
  (interactive)
  (let ((theme-dir (expand-file-name "theme" omarchy-current-dir)))
    (add-to-list 'load-path theme-dir)
    (add-to-list 'custom-theme-load-path "~/.config/emacs/themes")
    (when (file-exists-p (expand-file-name "omarchy-colors.el" theme-dir))
      (load-file (expand-file-name "omarchy-colors.el" theme-dir))
      (mapc #'disable-theme custom-enabled-themes)
      (dolist (theme '(omarchy omarchy-dark omarchy-light))
        (put theme 'theme-settings nil)
        (setq custom-known-themes (delq theme custom-known-themes)))
      (load-file (locate-file "omarchy-theme" custom-theme-load-path '(".el")))
      (enable-theme 'omarchy))))

(omarchy-apply-theme)

;; Reload on theme change. Watch theme.name, not the theme directory:
;; omarchy-theme-set replaces the directory, which drops inotify watches.
(let ((name-file (expand-file-name "theme.name" omarchy-current-dir)))
  (when (file-exists-p name-file)
    (file-notify-add-watch name-file '(change)
                           (lambda (_event) (omarchy-apply-theme)))))

;; Font settings
(set-frame-font "Liberation Mono 12" t)

;; Set Window/frame height and width
(if (window-system)
    (progn
      (set-frame-height (selected-frame) 45)
      (set-frame-width (selected-frame) 130)))

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
