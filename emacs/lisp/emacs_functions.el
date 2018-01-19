;;
;; The buffer switcher uses popup.el
;;
(require 'popup)

;;
;; This function returns the display position of the popup window
;; for the buffer switcher list
;;
(defun csharp-popup-point()  (point))


;;
;; This function returns the list of buffers for the buffer list
;; popup window.  The returned list is the list of buffers minus
;; any buffers that start with ' *'
;;
(defun csharp-buffer-list ()
  "return a list of buffers for display in a pop-up menu"
  ;; Filter the standard buffer list.  We remove all buffers
  ;; that start with a ' *'
  (seq-filter (lambda (buf)
                (not (equal (substring (buffer-name buf)0 2) " *")))
              (buffer-list)))

;;
;; Call this function to display the buffer switcher popup.
;;
(defun csharp-buffer-switcher()
  (interactive)
  (switch-to-buffer
  (popup-menu* (csharp-buffer-list) :point (csharp-popup-point) )))

;;
;; Bind Meta-Backtick, M-`, to the buffer switcher.
;;
(global-set-key "\M-`" 'csharp-buffer-switcher)

;;
;; Use C-n and C-p to choose nex and prev in ido.
;;
(defun bind-ido-keys ()
  "Keybindings for ido mode."
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook #'bind-ido-keys)

(provide 'emacs_functions)
