;;; -*- lexical-binding: t; -*-
;; Add your custom functions here

;; Duplicate line or whole region
(defun duplicate-current-line-or-region (arg)
  "Duplicate the current line, or the region, ARG times.

With no active region, duplicate the whole current line and leave
point where it was. With an active region, duplicate exactly the
selected text after the region."
  (interactive "p")
  (let* ((beg (if (use-region-p) (region-beginning) (line-beginning-position)))
         (end (if (use-region-p) (region-end) (line-end-position)))
         (text (buffer-substring-no-properties beg end))
         ;; A region that ends at the beginning of a line already carries the
         ;; separating newline; anything else needs one added.
         (separator (if (string-suffix-p "\n" text) "" "\n"))
         (origin (copy-marker (point))))
    (unwind-protect
        (progn
          (goto-char end)
          (dotimes (_ (max arg 1))
            (insert separator text))
          (goto-char origin))
      (set-marker origin nil))))

;; Reload my emacs configuration
(defun my-config-features ()
  "Return the features provided by the files in this configuration.

The list comes from `load-history' rather than a hard-coded list, so
newly added layers are picked up without editing this function."
  (let ((dir (file-name-as-directory
              (expand-file-name "elisp" user-emacs-directory)))
        features)
    (dolist (entry load-history features)
      (let ((file (car entry)))
        (when (and (stringp file)
                   (string-prefix-p dir (expand-file-name file)))
          ;; The cdr of an entry is a list of elements; features show up
          ;; as (provide . FEATURE).
          (dolist (element (cdr entry))
            (when (eq (car-safe element) 'provide)
              (push (cdr element) features))))))))

(defun my-reload-emacs-configuration ()
  "Reload this Emacs configuration from disk.

Every layer is unloaded first, because `require' is a no-op for an
already provided feature. Hooks are cleaned up by `unload-feature',
so repeated reloads do not duplicate them. Restart Emacs instead when
you change package selection or install new packages."
  (interactive)
  (dolist (feature (my-config-features))
    (when (featurep feature)
      (unload-feature feature t)))
  (load-file (expand-file-name "init.el" user-emacs-directory))
  (message "Emacs configuration reloaded from %s" user-emacs-directory))

(provide 'base-functions)
;;; base-functions ends here
