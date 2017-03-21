;;; Spelling -- Spell checking and related conf.

;;; Code:

;; Tell emacs to use hunspell as it spell correcting program
(if (file-exists-p "/usr/bin/hunspell")
    (progn
      (setq ispell-program-name "hunspell")
      (eval-after-load "ispell"
        '(progn (defun ispell-get-coding-system () 'utf-8)))))


(require 'flyspell-lazy)
(flyspell-lazy-mode 1)
(flyspell-prog-mode)
(ispell-change-dictionary "en_GB")

;; Should apparently improve performance when checking the entire code base.
(setq flyspell-issue-message-flag nil)


;; Automatic language detection in emacs buffers
(require 'guess-language)
(setq guess-language-languages '(en sv))
(setq guess-language-min-paragraph-length 40)
(setq guess-language-langcodes
			'((en . ("en_GB" "English"))
				(sv . ("sv_SE" "Swedish"))))

(add-hook 'text-mode-hook (lambda () (guess-language-mode 1)))

(provide 'spelling)
;;; spelling.el ends here
