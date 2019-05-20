;; Major mode of Terraform configuration file
;; https://github.com/syohex/emacs-terraform-mode
(use-package terraform-mode
  :defer t
  :config
  (setq terraform-packages '(terraform-mode)))

(provide 'lang-terraform)
