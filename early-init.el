;;; early-init.el --- Runs before init.el and before the first frame -*- lexical-binding: t; -*-
;;; Commentary:
;; Startup tuning: no GC pauses while loading, no menu/tool bar flicker,
;; larger process-output buffer for LSP servers.
;;; Code:

(setq gc-cons-threshold most-positive-fixnum
      read-process-output-max (* 1024 1024)
      frame-inhibit-implied-resize t
      inhibit-startup-screen t)

;; Restore a sane GC threshold once startup is done.
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 32 1024 1024))))

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;;; early-init.el ends here
