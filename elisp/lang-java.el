(use-package jdee
  :defer t
  :config
  (add-hook 'java-mode-hook 'jdee-mode)
  (custom-set-variables '(jdee-server-dir (substitute-in-file-name "${HOME}/.emacs.d/jdee-server"))))

(provide 'lang-java)
