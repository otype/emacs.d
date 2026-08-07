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

;; Automatically sync org-roam files to Google Drive on save
(defun my/sync-org-roam-to-gdrive ()
  "Run Python sync script on save for org-roam files."
  (when (string-prefix-p (expand-file-name org-roam-directory)
                         (buffer-file-name))
    (start-process "org-gdrive-sync" "*org-gdrive-sync*"
                   "python3" (expand-file-name "~/bin/org_to_gdocs.py")
                   (buffer-file-name))))

(add-hook 'after-save-hook #'my/sync-org-roam-to-gdrive)

(provide 'base-functions)
