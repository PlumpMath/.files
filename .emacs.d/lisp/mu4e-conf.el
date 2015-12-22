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
         ("/Studentmail"           . ?u)
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
     smtpmail-stream-type 'starttls-open-stream
     smtpmail-default-smtp-server "smtp.gmail.com"
     smtpmail-smtp-server "smtp.gmail.com"
     smtpmail-smtp-service 587)

;; Don't keep message buffers around.
(setq message-kill-buffer-on-exit t)


;; Modify settings depending on which account we're on.
(defvar my-mu4e-account-alist
	'(("rovanion.luckey@gmail.com"
     (smtpmail-stream-type 'starttls-open-stream)
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587)
		 (user-mail-address "rovanion.luckey@gmail.com"))
		("christian.luckey@liu.se"
     (smtpmail-stream-type 'starttls-open-stream)
     (smtpmail-smtp-server "mail.liu.se")
     (smtpmail-smtp-service 587)
		 (user-mail-address "christian.luckey@liu.se"))
		))

;; With the following function:
(defun my-mu4e-set-account ()
	"Set the account for composing a message."
	(let* ((account
					(if mu4e-compose-parent-message
							(let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
								(string-match "/\\(.*?\\)/" maildir)
								(match-string 1 maildir))
						(completing-read (format "Compose with account: (%s) "
																		 (mapconcat #'(lambda (var) (car var))
																								my-mu4e-account-alist "/"))
														 (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
														 nil t nil nil (caar my-mu4e-account-alist))))
				 (account-vars (cdr (assoc account my-mu4e-account-alist))))
		(if account-vars
				(mapc #'(lambda (var)
									(set (car var) (cadr var)))
							account-vars)
			(error "No email account found"))))
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

(provide 'mu4e-conf)
;;; mu4e-conf.el ends
