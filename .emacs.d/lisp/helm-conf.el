;;; helm-conf -- Personal configuration for helm.

;;; Code:

(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)


;; Helm-gtags conf
(setq helm-gtags-ignore-case t
			helm-gtags-auto-update t
			helm-gtags-use-input-at-cursor t
			helm-gtags-pulse-at-cursor t
			helm-gtags-prefix-key "\C-cg"
			helm-gtags-suggested-key-mapping t)

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; Keybinds can be found in keybinds.el

(provide 'helm-conf)
;;; helm-conf.el ends here
