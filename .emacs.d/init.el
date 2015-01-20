;;; init --- Initialises emacs.

;;; Commentary:
;; The init.el for Rovanion.  It is into a couple of files.  Specifically:
;; packages.el - Lists the packages needed for this config.
;;
;; Either of the following auto-complete sources should be used.
;; ac-conf.el - Configures auto-completion.
;; company-conf.el - Configures auto-completion, but with company-mode instead.

;;; Code:
;; Load files from here.
(add-to-list 'load-path "~/.emacs.d/")
;; Automatically download packages requiered for this conf.
(require 'packages)

;; Load auto complete configuration.
(require 'company-conf)

;; Put scroll bar on the right in graphical mode.
(set-scroll-bar-mode 'right)
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Hide the menu- and tool-bar in graphical mode.


;; Make scrolling by mouse linear
(setq mouse-wheel-progressive-speed nil)
;; And then scroll only one line per scroll event. Great for laptops.
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Indentation galore!
(setq-default tab-width 2
							js-indent-level tab-width
							js2-basic-offset tab-width
							sh-basic-offset tab-width
							sh-indentation tab-width
							sgml-basic-offset tab-width
							python-indent tab-width)

;; Color paranthesis in all the colors of the rainbow!
;; Requires the fallowing plugin http://www.emacswiki.org/emacs/RainbowDelimiters
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode 1)

;; And then highlight the parenthesis.
(show-paren-mode 1)

;; Start octave-mode when opening a file labeled .octave or .m
(add-to-list 'auto-mode-alist '("\\.octave\\'" . octave-mode))
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))
;; Turn on abbrevs, auto-fill and font-lock.
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

;; Run tex-mode when a .latex-file is opened
(add-to-list 'auto-mode-alist '("\\.latex\\'" . LaTeX-mode))
;; Use visual-line-mode in latex-mode
(add-hook 'LaTeX-mode-hook 'visual-line-mode)

;; Surpress emacs init screen
(setq inhibit-startup-screen t)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((eval compile-on-save-mode)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; Provides the minor mode which runs the compile comand on save
(require 'compile-on-save)
(add-hook 'LaTeX-mode-hook 'compile-on-save-mode)

;; Remove trailing whitespaces before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Code which tries to make *compile* on errorcodes != 0
(require 'only-display-compile-on-error)

;; Tell emacs to use hunspell as it spell correcting program
(if (file-exists-p "/usr/bin/hunspell")
    (progn
      (setq ispell-program-name "hunspell")
      (eval-after-load "ispell"
        '(progn (defun ispell-get-coding-system () 'utf-8)))))


;;;; This snippet enables lua-mode.
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; Lets try out skewer mode.
(add-hook 'js2-mode-hook  'skewer-mode)
(add-hook 'css-mode-hook  'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;; make js2-mode the mode for javascript files
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Should be a fix for <dead-acute> is undefined.
(require 'iso-transl)

;; And normal spell checking for latex documents
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;; Fix bug in terminal flycheck with company-mode
(add-hook 'flycheck-mode-hook
          (lambda ()
            (when (display-graphic-p)
              (setq-local flycheck-indication-mode nil))))

;; Don't litter the fs with temporary files but put them in a central folder.
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

;; Bind keys for moving to the next char of some type.
(global-set-key (kbd "M-n") 'iy-go-up-to-char)
(global-set-key (kbd "M-p") 'iy-go-to-char-backward)
(setq iy-go-to-char-key-forward '¨)
(setq iy-go-to-char-key-backward '^)

;; Load my custom settings for golang
(add-hook 'before-save-hook 'gofmt-before-save)

;; Set up ace-window
(setq aw-keys '(?a ?o ?e ?u ?h ?t ?n ?s))
(setq ace-jump-mode-move-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
(global-set-key (kbd "C-c C-SPC") 'ace-window)
(global-set-key (kbd "M-SPC") 'ace-jump-mode)

(add-to-list 'auto-mode-alist '("\\.md$" . jekyll-markdown-mode))
(add-to-list 'auto-mode-alist '("\\.html" . jekyll-html-mode))

;; Make align-regexp use spaces instead of tab characters.
(defadvice align-regexp (around align-regexp-with-spaces activate)
  (let ((indent-tabs-mode nil))
    ad-do-it))

;; Use Python 3 by default
(setq python-remove-cwd-from-path nil)
(custom-set-variables
 '(python-python-command "python3")
 '(python-shell-interpreter "python3"))

(provide 'init)
;;; init.el ends here
