;;; -*- lexical-binding: t; -*-
;; Nerd Font icons for Emacs; used by doom-modeline, centaur-tabs and dashboard.
;; https://github.com/rainstormstudio/nerd-icons.el
;; If icons show up as boxes, run `M-x nerd-icons-install-fonts' once.
(use-package nerd-icons)

;; This projects aims to become an aesthetic, functional and efficient tabs plugin for
;; Emacs with a lot of customization options.
;; https://github.com/ema2159/centaur-tabs
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-style      "rounded")
  (setq centaur-tabs-set-icons  t
        centaur-tabs-icon-type  'nerd-icons)
  (setq centaur-tabs-height     32)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>"  . centaur-tabs-forward))

;; A fancy and fast mode-line inspired by minimalism design.
;; https://github.com/seagle0128/doom-modeline
(use-package doom-modeline
  :init
  (setq doom-modeline-height 35
        doom-modeline-bar-width 1)
  :config
  (doom-modeline-mode 1))

;; Follow the current Omarchy theme. Only the colors are taken over from the
;; Omarchy Emacs integration (/usr/share/omarchy-emacs); fonts and the rest of
;; its setup are deliberately left out.
(require 'cl-lib)
(require 'filenotify)

(defvar omarchy-theme-watch nil
  "File notification descriptor for the Omarchy theme name file.")

(defvar omarchy-theme-dir (expand-file-name "themes" user-emacs-directory)
  "Directory holding this configuration's copy of `omarchy-theme.el'.")

(defun omarchy-current-dir ()
  "Return the directory holding Omarchy's current theme assets, or nil."
  (cl-find-if (lambda (d) (file-directory-p (expand-file-name "theme" d)))
              '("~/.local/state/omarchy/current" ; Omarchy 4
                "~/.config/omarchy/current")))   ; Omarchy 3

(defun my-omarchy-helm-faces ()
  "Make the Helm selection row follow the `region' face of the Omarchy theme.
Does nothing until Helm is loaded; Helm's `use-package' block calls this
too, and `omarchy-apply-theme' re-applies it on every theme switch."
  (when (facep 'helm-selection)
    (set-face-attribute 'helm-selection nil
                        :background (face-attribute 'region :background nil t)
                        :foreground (face-attribute 'region :foreground nil t))))

(defun omarchy-apply-theme ()
  "Load the colors of the current Omarchy theme as the `omarchy' Emacs theme."
  (interactive)
  (let* ((current (omarchy-current-dir))
         (theme-dir (and current (expand-file-name "theme" current)))
         (colors-file (and theme-dir
                           (expand-file-name "omarchy-colors.el" theme-dir))))
    (if (not (and colors-file (file-exists-p colors-file)))
        (message "Omarchy colors not available; skipping theme load.")
      (add-to-list 'load-path theme-dir)
      ;; The theme file ships with Omarchy but lives next to this config.
      (add-to-list 'custom-theme-load-path omarchy-theme-dir)
      (let ((theme-file (locate-file "omarchy-theme"
                                     custom-theme-load-path '(".el"))))
        (if (not theme-file)
            (message "No omarchy-theme.el found in %s" omarchy-theme-dir)
          ;; omarchy-colors.el only sets the colors its template rendered.
          ;; Unbind the semantic ones first so switching from a semantic theme
          ;; to a legacy color0..15 theme cannot leave stale values behind.
          (dolist (sym '(omarchy-color-muted omarchy-color-selection
                         omarchy-color-dark-fg omarchy-color-light-fg
                         omarchy-color-bright-fg omarchy-color-dark-bg
                         omarchy-color-darker-bg omarchy-color-lighter-bg
                         omarchy-color-orange))
            (makunbound sym))
          (load-file colors-file)
          ;; Disable and forget the theme symbols so the `load-file' below
          ;; rebuilds them instead of merging with the previous theme's faces.
          (dolist (theme '(omarchy omarchy-dark omarchy-light))
            (disable-theme theme)
            (put theme 'theme-settings nil)
            (setq custom-known-themes (delq theme custom-known-themes)))
          (load-file theme-file)
          (enable-theme 'omarchy)
          (my-omarchy-helm-faces))))))

(omarchy-apply-theme)

;; Reload on theme change. Watch theme.name, not the theme directory:
;; omarchy-theme-set does `rm -rf' + `mv' on theme/, which drops inotify
;; watches, while theme.name is rewritten in place. Remove the previous watch
;; first so reloading this file cannot stack watches.
(let* ((current (omarchy-current-dir))
       (name-file (and current (expand-file-name "theme.name" current))))
  (when (and name-file (file-exists-p name-file))
    (when omarchy-theme-watch
      (ignore-errors (file-notify-rm-watch omarchy-theme-watch)))
    (setq omarchy-theme-watch
          (file-notify-add-watch name-file '(change)
                                 (lambda (_event) (omarchy-apply-theme))))))

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

;; Cursor and region colors come from the Omarchy theme (`cursor' and `region'
;; faces in omarchy-theme.el), so they follow theme switches.

(provide 'base-theme)
