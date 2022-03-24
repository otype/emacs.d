(use-package rust-mode
  :defer t
  :config
  (add-hook 'rust-mode-hook
            (lambda () (setq indent-tabs-mode nil))
            (lambda () (prettify-symbols-mode)))
  (setq rust-format-on-save t))

(use-package cargo
  :defer t
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(use-package flycheck-rust
  :defer t
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(provide 'lang-rust)
