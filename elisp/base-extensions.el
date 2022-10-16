;; Whenever the window scrolls a light will shine on top of your cursor so you know where it is.
(use-package beacon
  :config
  (beacon-mode 1))

;; Company is a text completion framework for Emacs. The name stands for "complete anything".
;; It uses pluggable back-ends and front-ends to retrieve and display completion candidates.
;; https://company-mode.github.io/
(use-package company
  :custom
  (company-idle-delay 0.5) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; An extensible emacs startup screen showing you what’s most important.
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))
  (setq dashboard-set-navigator t))

;; This file documents Ediff, a comprehensive visual interface to Unix diff and patch utilities.
;; https://www.gnu.org/software/emacs/manual/html_node/ediff/
(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w"))

;;Expand region increases the selected region by semantic units. Just keep pressing the key
;; until it selects what you want.
;; https://github.com/magnars/expand-region.el
(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

;; Flycheck is a modern on-the-fly syntax checking extension for GNU Emacs, intended as
;; replacement for the older Flymake extension which is part of GNU Emacs.
;; https://www.flycheck.org/en/latest/
(use-package flycheck)

;; Helm is an Emacs framework for incremental completions and narrowing selections. It
;; helps to rapidly complete file names, buffer names, or any other Emacs interactions
;; requiring selecting an item from a list of possible choices.
;; https://github.com/emacs-helm/helm
(use-package helm
  :init
  (require 'helm-config)
  :config
  (setq helm-split-window-in-side-p t
        helm-split-window-default-side 'below
	helm-idle-delay 0.0
	helm-input-idle-delay 0.01
	helm-quick-update t
	helm-ff-skip-boring-files t)
  (set-face-attribute 'helm-selection nil :background "#FBFFC8" :foreground "#04134B")
  (helm-mode 1)
  :bind (("M-x"     . helm-M-x)
         ("C-x C-m" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ;; ("C-c j"   . helm-command-prefix)
         ("C-c j v" . helm-projectile)
         ("C-c j m" . helm-mini)
         ("C-c j o" . helm-occur)
         ("C-c j p" . helm-projectile-ag)
         ("C-c j a" . helm-do-ag)
         ("C-c j k" . helm-show-kill-ring)
         :map helm-map
         ("<tab>"   . helm-execute-persistent-action)))

;; helm-ag.el provides interfaces of The Silver Searcher with helm.
;; https://github.com/syohex/emacs-helm-ag
(use-package helm-ag)

;; Show flycheck errors with helm.
;; https://github.com/yasuyk/helm-flycheck
(use-package helm-flycheck)

;; helm for git-grep(1), an incremental git-grep(1).
;; https://github.com/yasuyk/helm-git-grep
(use-package helm-git-grep)

;; Helm UI for Projectile
;; https://github.com/bbatsov/helm-projectile
(use-package helm-projectile)

;; List match lines to another buffer, which is able to squeeze by any words you input.
;; At the same time, the original buffer's cursor is jumping line to line according
;; to moving up and down the line list.
;; https://github.com/ShingoFukuyama/helm-swoop
(use-package helm-swoop
  :bind
  ("C-x c s" . helm-swoop))

;; this package includes Emacs minor modes (iedit-mode and iedit-rectangle-mode)
;; based on a API library (iedit-lib) and allows you to edit one occurrence of some
;; text in a buffer (possibly narrowed) or region, and simultaneously have other
;; occurrences edited in the same way, with visual feedback as you type.
;; https://github.com/victorhge/iedit
(use-package iedit
  :bind
  ("C-s-;" . iedit-mode))

;; Magit is an interface to the version control system Git, implemented as an
;; Emacs package.
;; https://magit.vc/
(use-package magit
  :config
  :bind
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

;; This Emacs package provides several commands to switch between various line
;; positions, like moving to the beginning/end of code, line or comment.
;; https://github.com/alezost/mwim.el
(use-package mwim
  :bind
  ("C-a"    . mwim-beginning)
  ("<home>" . mwim-beginning)
  ("C-e"    . mwim-end)
  ("<end>"  . mwim-end))

;; Org mode is for keeping notes, maintaining TODO lists, planning projects, and
;; authoring documents with a fast and effective plain-text system.
;; https://orgmode.org/
(use-package org
  :config
  (setq org-directory "~/Documents/org-roam-notes"
        ;; org-default-notes-file (concat org-directory "/mw-tasks.org")
	)
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda))

(use-package org-roam
  :after org
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (file-truename org-directory))
  (org-roam-completion-everywhere t)
  :config
  (org-roam-setup)
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n r" . org-roam-node-random)
	 ("C-c n l" . org-roam-buffer-toggle)
         :map org-mode-map
         (("C-c n a" . org-roam-alias-add)
	  ("C-c n c"   . completion-at-point)
          ("C-c n i" . org-roam-node-insert)
          ("C-c n o" . org-id-get-create)
          ("C-c n t" . org-roam-tag-add))))

;; org-projectile provides functions for the creation of org-mode TODOs that are
;; associated with projectile projects.
;; https://github.com/IvanMalison/org-projectile
(use-package org-projectile
  :defer t
  :config
  (org-projectile-per-project)
  (setq org-projectile-per-project-filepath "todo.org"
	org-agenda-files (append org-agenda-files (org-projectile-todo-files))))

;; Prettify headings and plain lists in Org mode. This package is a direct
;; descendant of ‘org-bullets’, with most of the code base completely rewritten.
(use-package org-superstar
  :config
  (add-hook 'org-mode-hook
	    (lambda ()
	      (org-superstar-mode 1))))

;; This Emacs library provides a global mode which displays ugly form feed
;; characters as tidy horizontal rules.
;; https://github.com/purcell/page-break-lines
(use-package page-break-lines
  :defer t
  :config
  (global-page-break-lines-mode))

;; Projectile is a project interaction library for Emacs. Its goal is to provide
;; a nice set of features operating on a project level without introducing external
;; dependencies (when feasible).
;; https://github.com/bbatsov/projectile
(use-package projectile
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" temp-dir))

  (setq projectile-completion-system 'helm)
  (setq projectile-enable-caching t)
  (setq projectile-project-search-path '("~/src/" "~/tmp/"))
  (projectile-global-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map))

;; Recentf is a minor mode that builds a list of recently opened files. This list
;; is is automatically saved across sessions on exiting Emacs - you can then access
;; this list through a command or the menu.
;; https://www.emacswiki.org/emacs/RecentFiles
(use-package recentf
  :config
  (setq recentf-save-file (recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

;; Minor mode for Emacs that deals with parens pairs and tries to be smart about it.
;; https://github.com/Fuco1/smartparens
(use-package smartparens)

;; Emacs package that displays available keybindings in popup
;; https://github.com/justbur/emacs-which-key
(use-package which-key
  :config
  (which-key-mode))

;; Simple major mode to edit YAML file for emacs
;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :defer t
  :config
  (add-hook 'yaml-mode-hook
        (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(provide 'base-extensions)
