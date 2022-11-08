(use-package prettier-js
  :defer t
  :config
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode))

(use-package color-identifiers-mode
  :defer t
  :init
  (add-hook 'js2-mode-hook 'color-identifiers-mode)
  (add-hook 'web-mode-hook 'color-identifiers-mode))

(use-package ac-js2
  :defer t
  :config
  (add-hook 'js2-mode-hook 'ac-js2-mode)
  (add-hook 'web-mode-hook 'ac-js2-mode)
  (add-to-list 'company-backends 'ac-js2-company))

(use-package smartparens
  :defer t
  :config
  (require 'smartparens-config)
  (add-hook 'js-mode-hook  #'smartparens-strict-mode)
  (add-hook 'js2-mode-hook #'smartparens-strict-mode))

(use-package json-mode
  :defer t)

(use-package web-mode
  :defer t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.erb\\'"   . web-mode)
         ("\\.ejs\\'"   . web-mode))
  :init
  (require 'smartparens-config)
  (require 'prettier-js)
  (add-hook 'web-mode-hook 'prettier-js-mode)
  ;; (add-hook 'js2-mode-hook 'prettify-symbols-mode)
  (setq web-mode-markup-indent-offset  2
        web-mode-css-indent-offset     2
        web-mode-code-indent-offset    2
        web-mode-style-padding         2
        web-mode-script-padding        2))

(use-package js2-mode
  :defer t
  :init
  (setq-default tab-width                     2
                js2-basic-indent              2
                js2-basic-offset              2
                js2-auto-indent-p             t
                js2-cleanup-whitespace        t
                js2-concat-multiline-strings  'eol
                js2-enter-indents-newline     t
                js2-indent-on-enter-key       t
                indent-tabs-mode              nil
                js2-global-externs (list "window" "module" "require" "buster" "sinon" "assert" "refute"
                                         "setTimeout" "clearTimeout" "setInterval" "clearInterval" "location"
                                         "__dirname" "console" "JSON" "jQuery" "$")
                js2-strict-trailing-comma-warning       t
                js2-strict-inconsistent-return-warning  nil
                js2-strict-missing-semi-warning         nil)
  :config
  (add-hook 'js-mode-hook 'js2-minor-mode)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-hook 'js2-mode-hook
            (lambda () (flycheck-select-checker "javascript-eslint"))))

(provide 'lang-javascript)
