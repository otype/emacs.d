(use-package go-mode
  :config
  (setq tab-width         2
	      indent-tabs-mode  1)

  ;; ;; Use goimports instead of go-fmt
  ;; (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook 'company-mode)
  ;; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook 'setup-go-mode-compile)
  (add-hook 'go-mode-hook 'lsp-deferred)
  (add-hook 'go-mode-hook #'smartparens-strict-mode)
  (add-hook 'go-mode-hook (lambda ()
			     (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
  (add-hook 'go-mode-hook (lambda ()
			     (local-set-key (kbd "C-c C-g") 'go-goto-imports)))
  (add-hook 'go-mode-hook (lambda ()
			    (set (make-local-variable 'company-backends) '(company-go))
			    (company-mode))))

(use-package company-go
  :after go-mode
  :config
  (setq tab-width 4)
  (setq indent-tabs-mode 1)
  :bind (:map go-mode-map
	      ;; Godef jump key binding
	      ("M-." . godef-jump)
	      ("M-*" . pop-tag-mark)))

(use-package flycheck
  :config
  (add-hook 'go-mode-hook 'flycheck-mode))

(use-package flycheck-golangci-lint
  :hook (go-mode . flycheck-golangci-lint-setup)) ;; the same as :init + add-hook

(use-package go-eldoc
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package go-guru)

(defun setup-go-mode-compile ()
  ;; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet")))

(provide 'lang-go)
