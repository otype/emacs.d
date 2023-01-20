;; Cargo mode for Emacs. This package gives you a set of key combinations to perform Cargo
;; tasks within your Rust projects.
;; https://github.com/kwrooijen/cargo.el
(use-package cargo
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

;; This Flycheck extension configures Flycheck automatically for the current Cargo project.
;; https://github.com/flycheck/flycheck-rust
(use-package flycheck-rust
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; Rust development environment for Emacs
;; https://github.com/brotzeit/rustic
(use-package rustic
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-r l" . flycheck-list-errors)
              ("C-c C-r a" . lsp-execute-code-action)
              ("C-c C-r r" . lsp-rename)
              ("C-c C-r q" . lsp-workspace-restart)
              ("C-c C-r Q" . lsp-workspace-shutdown)
              ("C-c C-r s" . lsp-rust-analyzer-status))
  :config
  (require 'smartparens-config)
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t)))

;; See ./base-extensions.el for main configuration
;;
;; Client for Language Server Protocol (v3.14). lsp-mode aims to provide IDE-like
;; experience by providing optional integration with the most popular Emacs packages
;; like company, flycheck and projectile.
;; https://github.com/emacs-lsp/lsp-mode
(use-package lsp-mode
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")

  ;; Show inlay hints.
  (lsp-rust-analyzer-server-display-inlay-hints t)

  ;; Whether to show elided lifetime inlay hints.
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")

  ;; Whether to show inlay type hints for method chains. These hints will be
  ;; formatted with the type hint formatting options, if the mode is not
  ;; configured to ask the server to format them.
  (lsp-rust-analyzer-display-chaining-hints t)

  ;; When showing elided lifetime inlay hints, whether to use parameter names or
  ;; numeric placeholder names for the lifetimes.
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)

  ;; Whether to show closure return type inlay hints for closures with block bodies.
  (lsp-rust-analyzer-display-closure-return-type-hints t)

  ;; Whether to show function parameter name inlay hints at the call site.
  (lsp-rust-analyzer-display-parameter-hints nil)

  ;; Whether to show inlay type hints for compiler inserted reborrows.
  (lsp-rust-analyzer-display-reborrow-hints nil))

;; Smartparens is a minor mode for dealing with pairs in Emacs. It can
;; automatically insert pairs.
;; https://github.com/Fuco1/smartparens
(use-package smartparens
  :config
  (require 'smartparens-config)
  (add-hook 'rustic-mode-hook #'smartparens-strict-mode))

(provide 'lang-rust)
