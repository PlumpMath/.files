;;; nginx-conf -- Personal configuration for nginx conf files.

;;; Code:
(require 'nginx-mode)

(add-to-list 'auto-mode-alist '("\\`/etc/nginx/" . nginx-mode))

(provide 'nginx-conf)
;; Format before save,
