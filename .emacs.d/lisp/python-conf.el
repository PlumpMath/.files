;;; Code:
;; Use Python 3 by default
(setq python-remove-cwd-from-path nil)
(custom-set-variables
 '(python-python-command "python3")
 '(python-shell-interpreter "python3"))
(defun python-shell-parse-command ()
  "Return the string used to execute the inferior Python process."
  "/usr/bin/python3 -i"
  )

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(provide 'python-conf)
;;; python-conf.el ends here
