;; Major mode of Terraform configuration file
;; https://github.com/syohex/emacs-terraform-mode
(use-package terraform-mode
  :config
  (setq terraform-packages '(terraform-mode)))

(provide 'lang-terraform)
