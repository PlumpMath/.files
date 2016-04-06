;;; clojure-conf -- Personal configuration for Clojure and Clojurescript.

;;; Code:

;; Vertical align of arguments in sexps
(setq clojure-align-forms-automatically)
;; The emacs forward-word and backward-word stop in CamelCases.
(add-hook 'clojure-mode-hook #'subword-mode)


(provide 'clojure-conf)
;;; clojure-conf.el ends here
