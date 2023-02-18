(require 'package)
;; Choose either melpa-stable or bleedinge-edge melpa
;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org"   . "http://orgmode.org/elpa/") t)
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(defconst private-dir (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir)
  "Hostname-based elisp temp directories")

;; Core settings
;; UTF-8 please
(set-charset-priority                     'unicode)
(setq locale-coding-system                'utf-8)   ; pretty
(set-terminal-coding-system               'utf-8)   ; pretty
(set-keyboard-coding-system               'utf-8)   ; pretty
(set-selection-coding-system              'utf-8)   ; please
(prefer-coding-system                     'utf-8)   ; with sugar on top
(setq default-process-coding-system       '(utf-8-unix . utf-8-unix))

;; Emacs customizations
(setq confirm-kill-emacs                  'y-or-n-p
      confirm-nonexistent-file-or-buffer  t
      save-interprogram-paste-before-kill t
      mouse-yank-at-point                 t
      require-final-newline               t
      visible-bell                        nil
      ring-bell-function                  'ignore
      custom-file                         "~/.emacs.d/.custom.el"
      ;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
      minibuffer-prompt-properties
      '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)

      ;; Disable non selected window highlight
      cursor-in-non-selected-windows      nil
      highlight-nonselected-windows       nil
      ;; PATH
      exec-path                           (append exec-path '("/usr/local/bin/"))
      x-select-enable-clipboard           t
      use-package-always-ensure           t
      inhibit-compacting-font-caches      t
      ;; automatically open sym-linked files
      vc-follow-symlinks                  t
      find-file-visit-truename            t)

;; Load custom file
(load custom-file t)

;; Bookmarks
(setq bookmark-save-flag                  t
      bookmark-default-file               (concat temp-dir "/bookmarks"))

;; Personal information
(setq user-mail-address                   "hans@otype.de"
      user-full-name                      "Hans-Gunther Schmidt")

;; Save history
(savehist-mode 1)
(setq savehist-file                       "~/.emacs.d/savehist"
      history-length                      t
      history-delete-duplicates           t
      savehist-save-minibuffer-history    1)

;; Backups enabled, use nil to disable
(setq vc-make-backup-files                t
      create-lockfiles                    t
      backup-directory-alist              `(("." . "~/.trash"))
      make-backup-files                   t      ; backup of a file the first time it is saved.
      backup-by-copying                   t      ; don't clobber symlinks
      version-control                     t      ; version numbers for backup files
      delete-old-versions                 t      ; delete excess backup files silently
      delete-by-moving-to-trash           t
      kept-old-versions                   3      ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions                   3      ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default                   t      ; auto-save every buffer that visits a file
      auto-save-timeout                   20     ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval                  200    ; number of keystrokes between auto-saves (default: 300)
      )

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Prevent this message 'Package cl is deprecated' on startup
(setq byte-compile-warnings               '(cl-functions))

(provide 'base)
;;; base ends here
