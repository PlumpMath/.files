;;; clojure-conf -- Personal configuration for Clojure and Clojurescript.

;;; Code:

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

(add-hook 'markdown-mode-hook 'visual-line-mode)

(provide 'markdown-conf)
;;; markdown-conf.el ends here
