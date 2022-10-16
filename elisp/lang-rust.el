(use-package rustic
  :defer t
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
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

(use-package lsp-mode
  :defer t
  :commands lsp
  :custom
  ;; Symbol highlighting
  (lsp-enable-symbol-highlighting t)

  ;; Lenses
  (lsp-lens-enable t)

  ;; Headliner
  (lsp-headerline-breadcrumb-enable t)

  ;; Modeline code actions
  (lsp-modeline-code-actions-enable t)

  ;; Signature help documentation
  (lsp-signature-auto-activate nil)
  (lsp-signature-render-documentation nil)

  ;; what to use when checking on-save. "check" is default, I prefer clippy
  (lsp-rust-analyzer-cargo-watch-command "clippy")

  ;; Display all of the info returned by document/onHover. If this is set to nil,
  ;; eldoc will show only the symbol information.
  (lsp-eldoc-render-all t)

  ;; Debounce interval for after-change-functions.
  (lsp-idle-delay 0.6)

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
  (lsp-rust-analyzer-display-reborrow-hints nil)

  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package helm-lsp
  :defer t
  :commands
  helm-lsp-workspace-symbol)

(use-package lsp-ui
  :defer t
  :commands lsp-ui-mode
  :custom
  ;; enable lsp-ui-doc
  (lsp-ui-doc-enable t)

  ;; When non-nil, move the cursor over a symbol to show the doc
  (lsp-ui-doc-show-with-cursor nil)

  ;; When non-nil, move the mouse pointer over a symbol to show the doc
  (lsp-ui-doc-show-with-mouse t)

  (lsp-ui-peek-always-show -1)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions t))

(use-package cargo
  :defer t
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(use-package flycheck-rust
  :defer t
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package smartparens
  :defer t
  :config
  (require 'smartparens-config)
  (add-hook 'rustic-mode-hook #'smartparens-strict-mode))

(provide 'lang-rust)
