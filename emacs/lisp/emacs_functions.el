(require 'popup)


(defun csharp-popup-point()  (point))


(defun csharp-buffer-list ()
  "return a list of buffers for display in a pop-up menu"
  ;; Filter the standard buffer list.  We remove all buffers
  ;; that start with a ' *'
  (seq-filter (lambda (buf)
                (not (equal (substring (buffer-name buf)0 2) " *")))
              (buffer-list)))

(defun csharp-buffer-switcher()
  (interactive)
  (switch-to-buffer
  (popup-menu* (csharp-buffer-list) :point (csharp-popup-point) )))

(global-set-key "\M-`" 'csharp-buffer-switcher)

(provide 'emacs_functions)
