;;; package --- Main init file
;;; Commentary:
;;; This is my Emacs init file

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
(add-to-list 'load-path (concat user-emacs-directory "elisp"))

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
