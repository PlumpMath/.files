;;;;
;; Automatically download the required packages for emacs
;;;;
;; list the packages you want
(setq package-list '(js2-mode
                     skewer-mode
                     flycheck
                     pos-tip
                     iy-go-to-char
                     go-mode
                     company-go
                     ace-window
                     gitignore-mode
                     cmake-mode
                     yasnippet
                     glsl-mode
                     puppet-mode
                     web-mode
                     rainbow-delimiters
                     nginx-mode
                     dired+
                     lua-mode
                     omnisharp
                     yaml-mode
                     visual-regexp
                     markdown-mode
                     markdown-toc
                     recompile-on-save
                     company-jedi
                     toml-mode
                     mu4e-maildirs-extension
                     smart-tabs-mode
                     cider
                     smartparens
                     helm
                     helm-gtags
                     clj-refactor
										 php-mode))

;; list the repositories containing them
(setq package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
	(package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(provide 'packages)
;;; packages.el ends here
