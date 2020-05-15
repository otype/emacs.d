(use-package haskell-mode
  :ensure t
  :defer t
  :config
  (add-hook 'haskell-mode-hook #'hindent-mode)
  (custom-set-variables
   '(haskell-stylish-on-save t)))

(provide 'lang-haskell)
