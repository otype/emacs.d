;;; -*- lexical-binding: t; -*-
;; Add your custom functions here

;; Duplicate line or whole region
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
   If there's no region, the current line will be duplicated. However, if
   there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
	(exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
	(exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
	(goto-char end)
	(newline)
	(insert region)
	(setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

;; Reload my emacs configuration
(defun my-reload-emacs-configuration ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; Automatically export org-roam files to the meltwater-obsidian vault on save
(defun my/sync-org-roam-to-obsidian ()
  "Run the pandoc-based export script on save for org-roam files."
  (when (and (buffer-file-name)
             (string-prefix-p (expand-file-name org-roam-directory)
                               (expand-file-name (buffer-file-name))))
    (start-process "org-obsidian-sync" "*org-obsidian-sync*"
                   (expand-file-name "~/bin/generate-org-roam-obsidian-export")
                   (buffer-file-name))))

(add-hook 'after-save-hook #'my/sync-org-roam-to-obsidian)

(provide 'base-functions)
