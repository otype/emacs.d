(require 'mu4e)

;; default
(setq mu4e-maildir (expand-file-name "~/.mails/hansschmidtmeltwatercom"))

(setq mu4e-drafts-folder "/[Gmail]/Drafts")
(setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
(setq mu4e-trash-folder  "/[Gmail]/Trash")

;; don't save message to Sent Messages, GMail/IMAP will take care of this
(setq mu4e-sent-messages-behavior 'delete)

;; set visisble header lines
(setq mu4e-headers-visible-lines 30)

;; when to refresh mails
(setq mu4e-update-interval 900)

;; Save attachment (this can also be a function)
(setq mu4e-attachment-dir "~/Downloads")

;; Do not use 'fancy' non-ascii characters in various places in mu4e .. breaking the UI.
(setq mu4e-use-fancy-chars nil)

;; Silly mu4e only shows names in From: by default. Of course we also want the addresses.
(setq mu4e-view-show-addresses t)

;; See http://pragmaticemacs.com/emacs/fixing-duplicate-uid-errors-when-using-mbsync-and-mu4e/
(setq mu4e-change-filenames-when-moving t)

;; Show Smileys
(add-hook 'mu4e-view-mode-hook 'smiley-buffer)

;; Attempt to show images when viewing messages
(setq mu4e-show-images t
      mu4e-view-image-max-width 600)
(setq mu4e-view-show-images t
      mu4e-view-image-max-width 600)

;; use imagemagick to show images
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; setup some handy shortcuts
(setq mu4e-maildir-shortcuts
      '(("/inbox"             . ?i)
        ("/[Gmail]/All Mail"  . ?a)
        ("/[Gmail]/Sent Mail" . ?s)
        ("/[Gmail]/Drafts"    . ?d)
        ("/[Gmail]/Trash"     . ?t)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "mbsync -a")

;; something about ourselves
(setq
 user-mail-address "hans.schmidt@meltwater.com"
 user-full-name  "Hans-Gunther Schmidt"
 ;; message-signature
 ;; (concat
 ;;  "Hans-Gunther Schmidt\n"
 ;;  "Software Engineer | Meltwater Group | Berlin\n"
 ;;  "Office: +49 (0)30 293 692 0 | Skype: hans-gunther.schmidt\n"
 ;;  "Twitter: otype | LinkedIn: linkedin.com/in/hgschmidt | PGP: 0xAAACAC4B5C17BF81\n\n"
 ;;  "Take a look under the hood: https://underthehood.meltwater.com/\n")
)

;; sendmail configuration
(setq message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/local/bin/msmtp"
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-sendmail-f-is-evil 't)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(provide 'email)
