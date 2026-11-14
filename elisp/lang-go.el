;;; -*- lexical-binding: t; -*-

(defun setup-go-mode-compile ()
  "Point `compile-command' at the Go toolchain for the current buffer."
  (unless (string-match-p "go" compile-command)
    (setq-local compile-command "go build -v && go test -v && go vet")))

(defun my-go-mode-setup ()
  "Configure the current buffer for Go.

`tab-width' and `indent-tabs-mode' are automatically buffer-local, so
they must be set here rather than with `setq' while the config loads.
gofmt emits literal tabs and assumes eight-column tab stops."
  (setq-local indent-tabs-mode t)
  (setq-local tab-width 8)
  (company-mode 1)
  (flycheck-mode 1)
  (setup-go-mode-compile)
  (lsp-deferred)
  (smartparens-strict-mode 1)
  ;; Run gofmt on save, buffer-locally so it only affects Go files.
  (add-hook 'before-save-hook #'gofmt-before-save nil t)
  (local-set-key (kbd "C-c C-r") #'go-remove-unused-imports)
  (local-set-key (kbd "C-c C-g") #'go-goto-imports))

(use-package go-mode
  :config
  ;; ;; Use goimports instead of go-fmt
  ;; (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook #'my-go-mode-setup))

(use-package flycheck-golangci-lint
  :hook (go-mode . flycheck-golangci-lint-setup))

(provide 'lang-go)
