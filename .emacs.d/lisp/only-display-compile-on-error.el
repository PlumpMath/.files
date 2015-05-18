;; Code which tries to make *compile* on errorcodes != 0
(provide 'only-display-compile-on-error)

(defun brian-compile-finish (buffer outstr)
  (unless (string-match "finished" outstr)
    (switch-to-buffer-other-window buffer))
  t)

(setq compilation-finish-functions 'brian-compile-finish)

(require 'cl)

(defadvice compilation-start
  (around inhibit-display
      (command &optional mode name-function highlight-regexp)) 
  (if (not (string-match "^\\(find\\|grep\\)" command))
      (flet ((display-buffer)
         (set-window-point)
         (goto-char)) 
    (fset 'display-buffer 'ignore)
    (fset 'goto-char 'ignore)
    (fset 'set-window-point 'ignore)
    (save-window-excursion 
      ad-do-it))
    ad-do-it))

(ad-activate 'compilation-start)