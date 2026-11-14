;;; -*- lexical-binding: t; -*-
;; Format JavaScript on save with apheleia (prettier; needs `prettier' installed).
(add-hook 'js2-mode-hook #'apheleia-mode)

(use-package color-identifiers-mode
  :init
  (add-hook 'js2-mode-hook 'color-identifiers-mode)
  (add-hook 'web-mode-hook 'color-identifiers-mode))

(use-package smartparens
  :config
  (add-hook 'js-mode-hook  #'smartparens-strict-mode)
  (add-hook 'js2-mode-hook #'smartparens-strict-mode))

(use-package json-mode)

(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.erb\\'"   . web-mode)
         ("\\.ejs\\'"   . web-mode))
  :init
  ;; Format on save with apheleia (uses prettier; needs `prettier' installed).
  (add-hook 'web-mode-hook #'apheleia-mode)
  ;; (add-hook 'js2-mode-hook 'prettify-symbols-mode)
  (setq web-mode-markup-indent-offset  2
        web-mode-css-indent-offset     2
        web-mode-code-indent-offset    2
        web-mode-style-padding         2
        web-mode-script-padding        2))

(defun my-js-flycheck-setup ()
  "Enable Flycheck in the current JavaScript buffer and prefer ESLint.

`flycheck-select-checker' does nothing unless `flycheck-mode' is on,
which nothing else enabled for JavaScript buffers."
  (flycheck-mode 1)
  (flycheck-select-checker 'javascript-eslint))

(use-package js2-mode
  :init
  (setq-default tab-width                     2
                js2-basic-indent              2
                js-indent-level               2
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
  (add-hook 'js2-mode-hook #'my-js-flycheck-setup)
  (add-hook 'js-mode-hook #'my-js-flycheck-setup))

(provide 'lang-javascript)
