;;; clojure-conf -- Personal configuration for Clojure and Clojurescript.

;;; Code:

;; Vertical align of arguments in sexps
(setq clojure-align-forms-automatically t)
;; The emacs forward-word and backward-word stop in CamelCases.
(add-hook 'clojure-mode-hook #'subword-mode)

(setq cider-cljs-lein-repl
			"(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

;; Use company-mode with cider.
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
(setq cider-completion-annotations-include-ns t)

;; Use company in clojure-mode
(add-hook 'clojure-mode-hook #'company-mode)

(setq cider-diet-path
			(expand-file-name (concat (getenv "HOME") "/.local/bin/cider-diet.jar")))

(defun cider-diet-jack-in ()
	(interactive)
	(let* ((cider-diet-process (start-process "cider-diet-nrepl" "*cider-diet-nrepl*"
																						"java" "-jar" cider-diet-path "7888")))
		(accept-process-output cider-diet-process)
		    (cider-connect "localhost" 7888)))

(provide 'clojure-conf)
;;; clojure-conf.el ends here
