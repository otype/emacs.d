;; Add your custom functions here

;; (defun something
;;    (do-something))

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
(global-set-key (kbd "C-c d") 'duplicate-current-line-or-region)

(defun my-reload-emacs-configuration ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(provide 'base-functions)
