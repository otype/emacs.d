;; lsp-pyright provides fast Python type checking and completion via Pyright.
;; https://github.com/emacs-lsp/lsp-pyright
(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred))))

;; Black formatter for Python.
;; https://github.com/proofit404/blacken
(use-package blacken
  :hook (python-mode . blacken-mode))

(use-package pip-requirements
  :config
  (add-hook 'pip-requirements-mode-hook #'pip-requirements-auto-complete-setup))

(setq-default python-indent-offset 4)

(provide 'lang-python)
