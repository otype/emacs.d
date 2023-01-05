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
  :init
  (progn
    (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
    (setq dashboard-items              '((recents   . 10)
					 (bookmarks . 10)
					 (projects  . 10)
					 (agenda    . 5)
					 (registers . 5))
	  dashboard-set-navigator      t
	  dashboard-set-file-icons     t
	  dashboard-set-heading-icons  t
	  dashboard-startup-banner     'logo
	  dashboard-week-agenda        t))
  :config
  (dashboard-setup-startup-hook))

;; This file documents Ediff, a comprehensive visual interface to Unix diff and patch utilities.
;; https://www.gnu.org/software/emacs/manual/html_node/ediff/
(use-package ediff
  :config
  (setq ediff-window-setup-function        'ediff-setup-windows-plain)
  (setq ediff-split-window-function        'split-window-horizontally)
  (setq-default ediff-highlight-all-diffs  'nil)
  (setq ediff-diff-options "               -w"))

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
  :config
  (helm-mode 1)
  (set-face-attribute 'helm-selection nil :background "#FBFFC8" :foreground "#04134B")
  (setq helm-split-window-in-side-p     t
        helm-split-window-default-side  'below
	helm-idle-delay                 0.0
	helm-input-idle-delay           0.01
	helm-quick-update               t
	helm-ff-skip-boring-files       t
	helm-ag-insert-at-point         'symbol)
  :bind (("M-x"     . helm-M-x)
	 ("C-c C-m" . helm-M-x)
	 ("C-c C-f" . helm-find-files)
	 ("C-c h"   . helm-command-prefix)
	 :map helm-command-map
	 (("a" . helm-projectile-ag)
	  ("d" . helm-do-ag)
	  ("f" . helm-find-files)
	  ;("g" . helm-projectile-grep)
	  ("g" . helm-browse-project)
          ("k" . helm-show-kill-ring)
          ("m" . helm-mini)
          ("o" . helm-occur)
	  ("s" . helm-swoop)
	  ("v" . helm-projectile))
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
;;(use-package helm-git-grep)

;; Helm Git project manager.
;; https://github.com/emacs-helm/helm-ls-git
(use-package helm-ls-git)

;; This package provides alternative of the build-in lsp-mode xref-appropos which
;; provides as you type completion.
;; https://github.com/emacs-lsp/helm-lsp
(use-package helm-lsp
  :commands
  helm-lsp-workspace-symbol)

;; Helm UI for Projectile
;; https://github.com/bbatsov/helm-projectile
(use-package helm-projectile)

;; List match lines to another buffer, which is able to squeeze by any words you input.
;; At the same time, the original buffer's cursor is jumping line to line according
;; to moving up and down the line list.
;; https://github.com/ShingoFukuyama/helm-swoop
(use-package helm-swoop)

;; this package includes Emacs minor modes (iedit-mode and iedit-rectangle-mode)
;; based on a API library (iedit-lib) and allows you to edit one occurrence of some
;; text in a buffer (possibly narrowed) or region, and simultaneously have other
;; occurrences edited in the same way, with visual feedback as you type.
;; https://github.com/victorhge/iedit
(use-package iedit
  :bind
  ("C-s-;" . iedit-mode))

;; Client for Language Server Protocol (v3.14). lsp-mode aims to provide IDE-like
;; experience by providing optional integration with the most popular Emacs packages
;; like company, flycheck and projectile.
;; https://github.com/emacs-lsp/lsp-mode
(use-package lsp-mode
  :commands lsp
  :custom
  (lsp-enable-symbol-highlighting t)          ;; Symbol highlighting
  (lsp-headerline-breadcrumb-enable t)        ;; Headliner
  (lsp-idle-delay 0.6)                        ;; Debounce interval for after-change-functions.
  (lsp-lens-enable t)                         ;; Lenses
  (lsp-modeline-code-actions-enable t)        ;; Modeline code actions
  (lsp-signature-auto-activate nil)           ;; Signature help documentation
  (lsp-signature-render-documentation nil)    ;; Signature help documentation

  ;; Display all of the info returned by document/onHover. If this is set to nil,
  ;; eldoc will show only the symbol information.
  (lsp-eldoc-render-all t)

  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; This package contains all the higher level UI modules of lsp-mode, like flycheck
;; support and code lenses.
;; https://github.com/emacs-lsp/lsp-ui/
(use-package lsp-ui
  :defer t
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-enable t)                       ;; enable lsp-ui-doc
  (lsp-ui-doc-show-with-cursor nil)           ;; When non-nil, move the cursor over a
                                              ;; symbol to show the doc
  (lsp-ui-doc-show-with-mouse t)              ;; When non-nil, move the mouse pointer
                                              ;; over a symbol to show the doc
  (lsp-ui-peek-always-show -1)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions t))

;; Magit is an interface to the version control system Git, implemented as an
;; Emacs package.
;; https://magit.vc/
(use-package magit
  :config
  :bind
  ("C-c m c" . magit-commit)
  ("C-c m e" . magit-ediff-resolve)
  ("C-c m p" . magit-push)
  ("C-c m r" . magit-rebase-interactive)
  ("C-c m s" . magit-status)
  ("C-c m u" . magit-pull)
  ("C-c m x" . magit-checkout))

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
  (setq org-directory           "~/Nextcloud/Documents/org/"
        org-default-notes-file  (concat org-directory "/mw-tasks.org"))
;; 	   org-todo-keywords       '((sequence "☛ TODO(t)" "|" "<img draggable="false" role="img" class="emoji" alt="✔" src="https://s0.wp.com/wp-content/mu-plugins/wpcom-smileys/twemoji/2/svg/2714.svg"> DONE(d)")
;; 			    (sequence "⚑ WAITING(w)" "|")
;; 			    (sequence "|" "✘ CANCELED(c)")))
  :bind
  ("C-c o s" . org-store-link)
  ("C-c o a" . org-agenda))

;; Org-roam is a plain-text knowledge management system. It brings some of Roam's more
;; powerful features into the Org-mode ecosystem.
;; https://github.com/org-roam/org-roam
(use-package org-roam
  :after org
  :init
  (setq org-roam-v2-ack                 t
	org-roam-directory              (file-truename "~/org-roam-notes/")
	org-roam-completion-everywhere  t
	org-roam-capture-templates
	'(("p" "private" plain "%?" :target
           (file+head "private/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n") :unnarrowed t)
          ("w" "work" plain "%?" :target
           (file+head "work/%<%Y%m%d%H%M%S>-${slug}.org"  "#+title: ${title}\n") :unnarrowed t))
	)
  :bind (("C-c r f" . org-roam-node-find)
	 ("C-c r g" . org-roam-graph)
	 ("C-c r l" . org-roam-buffer-toggle)
	 ("C-c r r" . org-roam-node-random)
	 :map org-mode-map
         (("C-c r a" . org-roam-alias-add)
	  ("C-c r c" . completion-at-point)
	  ("C-c r d" . org-roam-dailies-capture-today)
	  ("C-c r e" . org-roam-capture)
	  ("C-c r i" . org-roam-node-insert)
	  ("C-c r o" . org-id-get-create)
          ("C-c r t" . org-roam-tag-add)))
  :config
  (org-roam-setup))

;; ;; Org-Roam-UI is a frontend for exploring and interacting with your org-roam notes.
;; ;; https://github.com/org-roam/org-roam-ui
;; (use-package org-roam-ui
;;     :after org-roam ;; or :after org
;; ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;; ;;         a hookable mode anymore, you're advised to pick something yourself
;; ;;         if you don't care about startup time, use
;; ;;  :hook (after-init . org-roam-ui-mode)
;;     :config
;;     (setq org-roam-ui-sync-theme t
;;           org-roam-ui-follow t
;;           org-roam-ui-update-on-save t
;;           org-roam-ui-open-on-start t))

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
  (setq projectile-known-projects-file  (expand-file-name "projectile-bookmarks.eld" temp-dir)
	projectile-completion-system    'helm
	projectile-enable-caching       t
	projectile-project-search-path  '("~/src/" "~/tmp/"))

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
