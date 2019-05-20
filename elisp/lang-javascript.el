(use-package web-mode
  :defer t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.ejs\\'" . web-mode))
  :init
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-style-padding 2
        web-mode-script-padding 2))

(use-package xref-js2
  :ensure t
  :defer t)

(use-package js2-mode
  :defer t
  :init
  (setq-default tab-width 2
                js2-basic-indent 2
                js2-basic-offset 2
                js2-auto-indent-p t
                js2-cleanup-whitespace t
                js2-concat-multiline-strings 'eol
                js2-enter-indents-newline t
                js2-indent-on-enter-key t
                indent-tabs-mode nil
                js2-global-externs (list "window" "module" "require" "buster" "sinon" "assert" "refute"
                                         "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location"
                                         "__dirname" "console" "JSON" "jQuery" "$")
                js2-strict-trailing-comma-warning t
                js2-strict-inconsistent-return-warning nil
                js2-strict-missing-semi-warning nil)
  :config
  (use-package json-mode :ensure t)
  (use-package prettier-js :ensure t)

  ;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
  ;; unbind it.
  (define-key js-mode-map (kbd "M-.") nil)

  (add-hook 'js-mode-hook 'js2-minor-mode)
  (add-hook 'js2-mode-hook
            (lambda ()
              (push '("function" . ?ƒ) prettify-symbols-alist)))

  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-hook 'js2-mode-hook
            (lambda () (flycheck-select-checker "javascript-eslint"))))

(use-package color-identifiers-mode
  :ensure t
  :init
  (add-hook 'js2-mode-hook 'color-identifiers-mode))

(use-package prettier-js
  :defer t
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode))

(provide 'lang-javascript)
