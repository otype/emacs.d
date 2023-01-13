(use-package vala-mode
  :init
  (add-to-list 'auto-mode-alist          '("\\.vala$"  . vala-mode))
  (add-to-list 'auto-mode-alist          '("\\.vapi$"  . vala-mode))
  (add-to-list 'file-coding-system-alist '("\\.vala$"  . utf-8))
  (add-to-list 'file-coding-system-alist '("\\.vapi$"  . utf-8)))

(provide 'lang-vala)
