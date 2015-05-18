;;; company-conf -- Personal configuration for complete anything.

;;; Code:

(setq company-tooltip-limit 20)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)

;; Trigger company-mode.
(add-hook 'c++-mode-hook        'company-mode)
(add-hook 'c-mode-hook          'company-mode)
(add-hook 'objc-mode-hook       'company-mode)
(add-hook 'lisp-mode-hook       'company-mode)
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'go-mode-hook         'company-mode)
(add-hook 'python-mode-hook     'company-mode)

;; Set up the python interpretern needed for company.
(defun run-python-once ()
  (remove-hook 'python-mode-hook 'run-python-once)
  (run-python))
(add-hook 'python-mode-hook 'run-python-once)

;; Only use company-go in go-mode
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (company-mode)))

(require 'company-go)

(provide 'company-conf)
