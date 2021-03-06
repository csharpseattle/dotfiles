;;
;;  Use MELPA package mananger
;;
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;;
;; Add the lisp folder to the load path.  This is the folder
;; for user elisp files.
;;
(add-to-list 'load-path "~/.emacs.d/lisp/")

;;
;;  Open all files in the same frame
;;
(setq ns-pop-up-frames nil)

;;
;;  Don't show the Emacs splash screen
;;
(setq inhibit-splash-screen t)

;;
;;  Auto save to temp dir
;;
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;;
;;  Use color theme misterioso
;;
(load-theme 'misterioso)

;;
;;  The cursor is hard to see in misterioso; change the color
;;
(setq default-frame-alist '((cursor-color . "#e9967a")))


;;  This will set the window size if opened with a window.
;;  note that emacsclient needs to be run with --frame-parameters
;;  to set the window size.
(if window-system (set-frame-size (selected-frame) 170 55))

;;
;;  Set a tab width of 4
;;
(setq c-default-style "linux" c-basic-offset 2)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(c-set-offset 'substatement-open 0)
(setq-default indent-tabs-mode nil)

;;
;;  Always attempt to show matching parentheses
;;
(show-paren-mode 1)

;;
;;  Rotate through buffers with Command-`
;;
(global-set-key "\M-`" 'next-buffer)

;;
;;  Add line numbers to margin
;;
(global-linum-mode 1)

;;
;;  Always highlight the current line
;;
(global-hl-line-mode 1)
(set-face-background 'hl-line "#222")
(set-face-foreground 'highlight nil)
(set-face-foreground 'hl-line nil)

;;
;;  Remove trailing whitespace on save
;;
(add-hook 'before-save-hook 'whitespace-cleanup)

(server-start)
