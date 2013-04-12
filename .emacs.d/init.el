;; Put scroll bar on the right in graphical mode.
(set-scroll-bar-mode 'right)
;; Hide the menu- and tool-bar in graphical mode.
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Make scrolling by mouse linear
(setq mouse-wheel-progressive-speed nil)
;; And then scroll only one line per scroll event. 
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Each level of indention in JS is 2 spaces.
(setq js-indent-level 2)

;; Color paranthesis in all the colors of the rainbow!
;; Requires the fallowing plugin http://www.emacswiki.org/emacs/RainbowDelimiters
(add-to-list 'load-path "~/.emacs.d/")
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode 1)

;; And then highlight the parenthesis
(show-paren-mode 1)

;; Auto complete mode. Fetched from the fallowing URL:
;; http://cx4a.org/software/auto-complete/
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
;; Load the default config
(ac-config-default)
;; Say with a stern voice that capital letters matter.
;;(setq ac-ignore-case nil)
;; Start showing completions with no delay.
(setq ac-delay 0)
(setq ac-auto-start 1)
;; Try to use spell correction if there are no matches.
;; TODO: This does not work, fix it.
(setq ac-use-fuzzy 1)
