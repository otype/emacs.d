(use-package go-mode
  :defer t
  :config
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook 'company-mode)
  ;; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook 'setup-go-mode-compile)
  (add-hook 'go-mode-hook #'smartparens-mode)
  (add-hook 'go-mode-hook '(lambda ()
			     (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
  (add-hook 'go-mode-hook '(lambda ()
			     (local-set-key (kbd "C-c C-g") 'go-goto-imports)))
  (add-hook 'go-mode-hook (lambda ()
			    (set (make-local-variable 'company-backends) '(company-go))
			    (company-mode))))

(use-package company-go
  :defer t
  :after go-mode
  :config
  (setq tab-width 4)
  (setq indent-tabs-mode 1)

  :bind (:map go-mode-map
  ; Godef jump key binding
	      ("M-." . godef-jump)
	      ("M-*" . pop-tag-mark)
	      ))

(use-package flycheck
  :defer t
  :config
  (add-hook 'go-mode-hook 'flycheck-mode))

(use-package flycheck-gometalinter
  :defer t
  :config
  (progn
    "Enable `flycheck-gometalinter' and disable overlapping `flycheck' linters."
    (setq flycheck-disabled-checkers '(go-gofmt
				       go-golint
				       go-vet
				       go-build
				       go-test
				       go-errcheck))
    (flycheck-gometalinter-setup)
    (add-hook 'go-mode-hook 'go-enable-gometalinter t)
    ;; skips 'vendor' directories and sets GO15VENDOREXPERIMENT=1
    (setq flycheck-gometalinter-vendor t)
    ;; ;; only show errors
    ;; (setq flycheck-gometalinter-errors-only t)
    ;; ;; only run fast linters
    ;; (setq flycheck-gometalinter-fast t)
    ;; use in tests files
    (setq flycheck-gometalinter-test t)))

(use-package go-eldoc
  :defer t
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(use-package go-guru :defer t)

(defun setup-go-mode-compile ()
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet")))

(provide 'lang-go)
