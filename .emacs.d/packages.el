;;;;
;; Automatically download the required packages for emacs
;;;;
;; list the packages you want
(setq package-list '(js2-mode
										 auto-complete
										 ac-js2
										 ac-math
										 ac-octave
										 skewer-mode
										 flycheck
										 pos-tip
										 auto-complete-clang-async
										 iy-go-to-char
										 go-mode
										 company-go
										 ))

;; list the repositories containing them
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
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
