;;;;
;; Custom keybindings.
;;;;

(defun smart-line-beginning ()
  "Move point to the beginning of text on the current line; if that is already
the current position of point, then move it to the beginning of the line."
  (interactive)
  (let ((pt (point)))
    (beginning-of-line-text)
    (when (eq pt (point))
      (beginning-of-line))))

(define-key prog-mode-map (kbd "RET") 'newline-and-indent)
(define-key prog-mode-map (kbd "C-j") 'newline)
(define-key prog-mode-map (kbd "C-a") 'smart-line-beginning)
(define-key prog-mode-map (kbd "C-o") 'split-line)
(define-key prog-mode-map (kbd "C-M-o") 'open-line)

(define-key c-mode-map (kbd "RET") 'newline-and-indent)
(define-key c-mode-map (kbd "C-j") 'newline)
(define-key c-mode-map (kbd "C-a") 'smart-line-beginning)
(define-key c-mode-map (kbd "C-o") 'split-line)
(define-key c-mode-map (kbd "C-M-o") 'open-line)


(require 'visual-regexp)
(define-key global-map (kbd "C-c r") 'vr/replace)
(define-key global-map (kbd "M-%") 'vr/query-replace)
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; If you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)

(global-set-key (kbd "<f5>") 'recompile)
(global-set-key (kbd "C--") 'undo)

;; The following binds browse-kill-ring to M-y.
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; Bind keys for moving to the next char of some type.
(global-set-key (kbd "M-n") 'iy-go-up-to-char)
(global-set-key (kbd "M-p") 'iy-go-to-char-backward)
(setq iy-go-to-char-key-forward '¨)
(setq iy-go-to-char-key-backward '^)

;; Set up ace-window
(setq aw-keys '(?a ?o ?e ?u ?h ?t ?n ?s))
(setq ace-jump-mode-move-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
(global-set-key (kbd "C-c C-SPC") 'ace-window)
(global-set-key (kbd "M-SPC") 'ace-jump-mode)

;; Remove word backwards with C-BSPC
(global-set-key "\C-h" 'backward-kill-word)


;; Helm
(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-å") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)


(provide 'keybinds)
;;; keybinds.el ends here
