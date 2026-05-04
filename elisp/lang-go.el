(use-package go-mode
  :config
  (setq tab-width         2
	      indent-tabs-mode  1)

  ;; ;; Use goimports instead of go-fmt
  ;; (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook 'company-mode)
  (add-hook 'go-mode-hook 'flycheck-mode)
  (add-hook 'go-mode-hook 'setup-go-mode-compile)
  (add-hook 'go-mode-hook 'lsp-deferred)
  (add-hook 'go-mode-hook #'smartparens-strict-mode)
  ;; Run gofmt on save, buffer-locally so it only affects Go files
  (add-hook 'go-mode-hook
            (lambda ()
              (add-hook 'before-save-hook 'gofmt-before-save nil t)))
  (add-hook 'go-mode-hook (lambda ()
			     (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
  (add-hook 'go-mode-hook (lambda ()
			     (local-set-key (kbd "C-c C-g") 'go-goto-imports))))

(use-package flycheck-golangci-lint
  :hook (go-mode . flycheck-golangci-lint-setup))

(defun setup-go-mode-compile ()
  ;; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet")))

(provide 'lang-go)
