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

(setq jedi:environment-root "jedi-virtualenv")
(setq jedi:environment-virtualenv
      (list "virtualenv" "--system-site-packages -p /usr/bin/python3"))

;; Set up the python interpretern needed for company.
(defun run-python-once ()
  (remove-hook 'python-mode-hook 'run-python-once)
  (run-python))
(add-hook 'python-mode-hook 'run-python-once)

(provide 'python-conf)
;;; python-conf.el ends here
