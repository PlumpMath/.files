;;; mu4e-conf -- Personal conf for the mu4e email client. Remember to
;;; install mu4e separately, either through your package manager or
;;; from source: https://github.com/djcb/mu

;;; Code:

;; In case you have compiled mu4e yourself.
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

(require 'mu4e)
(setq mu4e-maildir (expand-file-name "~/.cache/mail/gmail"))
(setq mu4e-drafts-folder "/[Gmail]/.Utkast")
(setq mu4e-sent-folder   "/Sent")
(setq mu4e-trash-folder  "/[Gmail]/.Papperskorgen")

(setq mu4e-maildir-shortcuts
      '( ("Inbox"                  . ?i)
         ("/Sent"                  . ?s)
         ("/[Gmail]/Papperskorgen" . ?t)
         ("/[Gmail]/.Utkast"       . ?d)))


(setq mu4e-show-images t)

;; Use imagemagic if available.
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(add-hook 'mu4e-compose-mode-hook
        (defun my-do-compose-stuff ()
           "My settings for message composition."
           (set-fill-column 80)
           (flyspell-mode)))


;; Load an extension which lists maildirs on the main mu4e page.
(require 'mu4e-maildirs-extension)
(mu4e-maildirs-extension)


;; SMTP
(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials
      '(("smtp.gmail.com" 587 nil nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-debug-info t)

(provide 'mu4e-conf)
;;; mu4e-conf.el ends
