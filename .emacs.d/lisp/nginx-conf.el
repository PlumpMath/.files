;;; nginx-conf -- Personal configuration for nginx conf files.

;;; Code:
(require 'nginx-mode)

(add-to-list 'auto-mode-alist '("\\`/etc/nginx/" . nginx-mode))

;; Please use tabs mr. nginx-mode.
(setq nginx-indent-tabs-mode t)

(provide 'nginx-conf)
;; Format before save,
