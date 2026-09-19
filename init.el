;;; package --- Main init file -*- lexical-binding: t; -*-
;;; Commentary:
;;; This is my Emacs init file

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
(add-to-list 'load-path (concat user-emacs-directory "elisp"))

;; Omarchy theme integration (colors follow the system theme).
;; omarchy.el only looks in ~/.config/emacs/themes, so add our own dir.
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
(load "/usr/share/omarchy-emacs/config/omarchy.el" t)

;; Personal information
(require 'user)

;; Base layers
(require 'base)
(require 'base-theme)
(require 'base-extensions)

;; Custom functions and keybindings
(require 'base-functions)
(require 'base-global-keys)

;; Language layers
(require 'lang-elixir)
(require 'lang-go)
;; (require 'lang-haskell)
;; (require 'lang-java)
(require 'lang-javascript)
(require 'lang-lisp)
(require 'lang-python)
;; (require 'lang-ruby)
(require 'lang-rust)
(require 'lang-terraform)
;; (require 'lang-vala)
