(use-package alchemist
  :ensure t
  :defer t
  :config
  (add-hook 'elixir-mode-hook 'alchemist-mode))

(use-package flycheck-mix
  :ensure t
  :defer t
  :commands (flycheck-mix-setup))

(use-package elixir-mode
  :ensure t
  :defer t)

(provide 'lang-elixir)
