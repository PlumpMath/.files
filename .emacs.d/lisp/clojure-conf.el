;;; clojure-conf -- Personal configuration for Clojure and Clojurescript.

;;; Code:

;; Vertical align of arguments in sexps
(setq clojure-align-forms-automatically t)
;; The emacs forward-word and backward-word stop in CamelCases.
(add-hook 'clojure-mode-hook #'subword-mode)

(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

(provide 'clojure-conf)
;;; clojure-conf.el ends here
