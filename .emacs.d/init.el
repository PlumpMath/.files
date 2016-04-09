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
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Automatically download packages requiered for this conf.
(require 'packages)
;; Load auto complete configuration.
(require 'company-conf)
;; Load language specific configurations.
(require 'python-conf)
(require 'go-conf)
(require 'clojure-conf)
(require 'nginx-conf)
;; Load conf for mail client.
(require 'mu4e-conf)
;; Conf for directory listing mode.
(require 'dired-conf)
;; Collection of keybinding customizations
(require 'keybinds)

;; Put scroll bar on the right in graphical mode, also remove toolbars.
(defun graphical-fixes (dummy)
  (menu-bar-mode -1)
  (when (boundp 'set-scroll-bar-mode)
    (set-scroll-bar-mode 'right)
    (tool-bar-mode -1)))
(add-to-list 'after-make-frame-functions #'graphical-fixes)


;; Make scrolling by mouse linear
(setq mouse-wheel-progressive-speed nil)
;; And then scroll only one line per scroll event. Great for laptops.
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))


;; Indentation galore!
(setq-default tab-width 2
              indent-tabs-mode t
              js-indent-level tab-width
              js2-basic-offset tab-width
              sh-basic-offset tab-width
              sh-indentation tab-width
              sgml-basic-offset tab-width
              python-indent tab-width
              web-mode-markup-indent-offset tab-width
              nginx-indent-level tab-width)

;; Color paranthesis in all the colors of the rainbow!
(require 'rainbow-delimiters)
(add-hook 'c++-mode-hook #'rainbow-delimiters-mode)
(add-hook 'c-mode-hook #'rainbow-delimiters-mode)
(add-hook 'python-mode-hook #'rainbow-delimiters-mode)
(add-hook 'js2-mode-hook #'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook #'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
(add-hook 'go-mode-hook #'rainbow-delimiters-mode)
(add-hook 'octave-mode-hook #'rainbow-delimiters-mode)

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
;; Provides the minor mode which runs the compile comand on save.
(add-hook 'LaTeX-mode-hook 'recompile-on-save-mode)


;; Remove trailing whitespaces before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Surpress emacs init screen
(setq inhibit-startup-screen t)

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


;; Fix bug in terminal flycheck with company-mode.
(add-hook 'flycheck-mode-hook
          (lambda ()
            (when (display-graphic-p)
              (setq-local flycheck-indication-mode nil))))
;; We're writing C++11, and we want want flycheck on by default.
(add-hook 'c++-mode-hook
          (lambda ()
            (setq flycheck-clang-language-standard "c++11")
            (flycheck-mode)))


;; Don't litter the fs with temporary files but put them in a central folder.
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name
                  (concat user-emacs-directory "auto-saves/")) t)))
(setq backup-by-copying t    ; Copy all files, don't rename them.
			delete-old-versions t  ; Don't ask to delete old versions.
			kept-new-versions 6
			kept-old-versions 2
			version-control t      ; Use versioned backups.
			vc-make-backup-files t ; Make backups of version controlled files.
			auto-save-default t    ; auto-save every buffer that visits a file
			auto-save-timeout 15   ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 150 ; number of keystrokes between auto-saves (default: 300)
			)


(add-to-list 'auto-mode-alist '("\\.md$" . jekyll-markdown-mode))
(add-to-list 'auto-mode-alist '("\\.html" . jekyll-html-mode))

;; Make align-regexp use spaces instead of tab characters.
(defadvice align-regexp (around align-regexp-with-spaces activate)
  (let ((indent-tabs-mode nil))
    ad-do-it))

;; Configure yasnippet
(yas-global-mode 1)

;; Remove word backwards with C-BSPC
(global-set-key "\C-h" 'backward-kill-word)


;; Auto wrap comments
(require 'newcomment)
(setq fill-column 66)
(setq comment-auto-fill-only-comments t)
(auto-fill-mode t)

;; Use diff-mode in commit messages.
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))

;; Troll coworkers - use Emacs at work for csharp!
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(setq omnisharp-server-executable-path '~/source/OmniSharp/OmniSharp/bin/Debug/OmniSharp.exe)

;; Reload Firefox page through MozRepl.
(require 'moz)
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(defun auto-reload-firefox-on-after-save-hook ()
  (add-hook 'after-save-hook
            '(lambda ()
               (interactive)
               (comint-send-string (inferior-moz-process)
                                   "setTimeout(BrowserReload, \"100\");"))
            'append 'local)) ; buffer-local

(add-hook 'toml-mode-hook 'auto-reload-firefox-on-after-save-hook)

;; Expand path to binaries installed in home folder.
(setenv "PATH" (concat (getenv "PATH") ":~/.local/bin"))
(setq exec-path (append exec-path '("~/.local/bin")))

;; Tabs for indentation, spaces for alignment.
(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'nxml 'ruby)

;; Automatically deal with parentheses
(require 'smartparens-config)
(smartparens-global-mode)
(smartparens-strict-mode)

;; We can handle it!
(put 'upcase-region 'disabled nil)

(provide 'init)
;;; init.el ends here
