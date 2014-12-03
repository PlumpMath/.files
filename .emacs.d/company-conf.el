;;; company-conf -- Personal configuration for complete anything.

;;; Code:

;; Auto complete everything!
;(add-hook 'after-init-hook 'global-company-mode)

(setq company-tooltip-limit 20)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 3)

;; Configuration for irony-mode together with company-mode
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

;; Trigger company-mode
(add-hook 'c++-mode-hook 'company-irony)
(add-hook 'c-mode-hook 'company-irony)
(add-hook 'objc-mode-hook 'company-irony)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)

(provide 'company-conf)
