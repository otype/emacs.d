(use-package enh-ruby-mode
  :defer t
  :mode
  (("\\.rb\\'" . ruby-mode)))

(use-package robe
  :defer t
  :config
  (push 'company-robe company-backends))

(use-package rinari
  :defer t)

(provide 'lang-ruby)
