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
(ispell-change-dictionary "english")

;; Should apparently improve performance when checking the entire code base.
(setq flyspell-issue-message-flag nil)


(provide 'spelling)
;;; spelling.el ends here
