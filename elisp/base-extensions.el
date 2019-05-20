;; Ace jump mode is a minor mode of emacs, which help you to move the cursor within Emacs.
;; You can move your cursor to ANY position ( across window and frame ) in emacs by using
;; only 3 times key press. Have a try and I am sure you will love it.
;; https://github.com/winterTTr/ace-jump-mode
(use-package ace-jump-mode
  :bind
  ("C-c SPC" . ace-jump-mode))


;; Company is a text completion framework for Emacs. The name stands for "complete anything".
;; It uses pluggable back-ends and front-ends to retrieve and display completion candidates.
;; https://company-mode.github.io/
(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;; This file documents Ediff, a comprehensive visual interface to Unix diff and patch utilities.
;; https://www.gnu.org/software/emacs/manual/html_node/ediff/
(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
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
  (helm-mode 1)
  :bind (("M-x" . helm-M-x)
         ("C-x C-m" . helm-M-x)
         ("C-x C-f" . helm-find-files)
	 ("C-c h"   . helm-command-prefix)
         ("C-c h v" . helm-projectile)
	 ("C-c h m" . helm-mini)
         ("C-c h o" . helm-occur)
         ("C-c h p" . helm-projectile-ag)
         ("C-c h a" . helm-do-ag)
         ("C-c c k" . helm-show-kill-ring)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action)))

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

;; https://github.com/ShingoFukuyama/helm-swoop
(use-package helm-swoop
  :bind
  ("C-x c s" . helm-swoop))

;; This library extends linum-mode to highlight current line number.
;; https://github.com/tom-tan/hlinum-mode
(use-package hlinum
  :ensure t
  :config
  (hlinum-activate))

(use-package linum
  :config
  (setq linum-format "%4d")
  (global-linum-mode nil))

;; this package includes Emacs minor modes (iedit-mode and iedit-rectangle-mode)
;; based on a API library (iedit-lib) and allows you to edit one occurrence of some
;; text in a buffer (possibly narrowed) or region, and simultaneously have other
;; occurrences edited in the same way, with visual feedback as you type.
;; https://github.com/victorhge/iedit
(use-package iedit
  :ensure t)

;; Magit is an interface to the version control system Git, implemented as an
;; Emacs package.
;; https://magit.vc/
(use-package magit
  :ensure t
  :config
  :bind
  ;; Magic
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
  ("C-a" . mwim-beginning)
  ("C-e" . mwim-end))

(use-package org
  :config
  (setq org-directory "~/org"
        org-default-notes-file (concat org-directory "/mw-tasks.org"))
  :bind
  ("C-c l" . org-store-link)
  ("C-c a" . org-agenda))

(use-package org-projectile
  :config
  (org-projectile-per-project)
  (setq org-projectile-per-project-filepath "todo.org"
	org-agenda-files (append org-agenda-files (org-projectile-todo-files))))

(use-package org-bullets
  :config
  (setq org-hide-leading-stars t)
  (add-hook 'org-mode-hook
            (lambda ()
              (org-bullets-mode t))))

(use-package page-break-lines)

(use-package projectile
  :ensure t
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" temp-dir))

  (setq projectile-completion-system 'helm)
  (setq projectile-enable-caching t)
  (setq projectile-project-search-path '("~/src/" "~/misc/"))
  (projectile-global-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(use-package recentf
  :config
  (setq recentf-save-file (recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

(use-package smartparens)

(use-package smex)

(use-package undo-tree
  :config
  ;; Remember undo history
  (setq
   undo-tree-auto-save-history nil
   undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/"))))
  (global-undo-tree-mode 1))

(use-package which-key
  :config
  (which-key-mode))

(use-package wgrep)

(use-package yaml-mode
  :defer t
  :config
  (add-hook 'yaml-mode-hook
        (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

(use-package yasnippet
  :config
  (yas-global-mode 1))


;;
;; TO BE EVALUATED
;;

;; (use-package multiple-cursors
;;   :bind
;;   ("C-S-c C-S-c" . mc/edit-lines)
;;   ("C->" . mc/mark-next-like-this)
;;   ("C-<" . mc/mark-previous-like-this)
;;   ("C-c C->" . mc/mark-all-like-this))

;; https://github.com/magit/magit-popup
;; (use-package magit-popup)


(provide 'base-extensions)
