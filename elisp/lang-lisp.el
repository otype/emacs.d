(use-package smartparens
  :defer t
  :config
  (add-hook 'lisp-mode-hook 'smartparens-strict-mode)
  (add-hook 'emacs-lisp-mode-hook 'smartparens-strict-mode))

(provide 'lang-lisp)
