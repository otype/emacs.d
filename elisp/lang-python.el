;;; -*- lexical-binding: t; -*-
;; lsp-pyright provides fast Python type checking and completion via Pyright.
;; https://github.com/emacs-lsp/lsp-pyright
(defun my-python-lsp ()
  "Load lsp-pyright on first use and start LSP for this buffer."
  (require 'lsp-pyright)
  (lsp-deferred))

(use-package lsp-pyright
  :defer t
  :hook ((python-mode python-ts-mode) . my-python-lsp))

;; Format Python on save with apheleia (uses black by default; needs `black' installed).
(add-hook 'python-mode-hook #'apheleia-mode)

(use-package pip-requirements
  :defer t)

(setq-default python-indent-offset 4)

(provide 'lang-python)
