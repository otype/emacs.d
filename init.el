;;; package --- Main init file
;;; Commentary:
;;; This is my Emacs init file

;;; Code:

;; Taken from here: https://github.com/bbatsov/prelude/issues/1225#issuecomment-511266025
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

;; Base layers
(require 'base)
(require 'base-theme)
(require 'base-extensions)

;; Custom functions and keybindings
(require 'base-functions)
(require 'base-global-keys)

;; Email
;;(require 'email)

;; Language layers
;(require 'lang-elixir)
(require 'lang-go)
;(require 'lang-haskell)
;(require 'lang-java)
;(require 'lang-javascript)
(require 'lang-lisp)
;(require 'lang-python)
;(require 'lang-ruby)
(require 'lang-rust)
;(require 'lang-terraform)
;(require 'lang-vala)

;; To speed up, compile to bytecode (see https://stackoverflow.com/a/8902202)
;; DISABLE ON FIRST START OF EMACS (or when clearing ~/.emacs.d/elpa)
;; If installation of elpa modules fails: $ find ~/.emacs.d -name *.elc | xargs rm -f
;;(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)
