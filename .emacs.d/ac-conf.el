;;; Code:
;; Start showing completions with no delay.
(setq ac-delay 0)
(setq ac-auto-start 1)
(setq ac-use-quick-help t)
(setq ac-quick-help-delay 1)
(setq ac-use-fuzzy t)

;; Set an auto complete key
;(define-key ac-mode-map (kbd "<backtab>") 'auto-complete)


;; The LLVM completion stuff for C++
;(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process))

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (global-auto-complete-mode t))

(my-ac-config)

(provide 'ac-conf)
;;; ac-conf.el ends here
