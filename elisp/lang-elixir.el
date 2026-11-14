;;; -*- lexical-binding: t; -*-

(defun my-elixir-format-arguments ()
  "Point `elixir-format-arguments' at the project's .formatter.exs, if any.

`locate-dominating-file' returning nil used to leave a bogus relative
path behind, so only set the argument when a formatter file exists."
  (let ((formatter (and buffer-file-name
                        (locate-dominating-file buffer-file-name
                                                ".formatter.exs"))))
    (setq-local elixir-format-arguments
                (when formatter
                  (list "--dot-formatter"
                        (expand-file-name ".formatter.exs" formatter))))))

(defun my-elixir-mode-setup ()
  "Format the current Elixir buffer on save and start LSP."
  ;; Buffer-local, so only Elixir files run the formatter.
  (add-hook 'before-save-hook #'elixir-format nil t)
  (lsp-deferred))

(use-package elixir-mode
  :config
  (add-hook 'elixir-format-hook #'my-elixir-format-arguments)
  (add-hook 'elixir-mode-hook #'my-elixir-mode-setup))

(provide 'lang-elixir)
