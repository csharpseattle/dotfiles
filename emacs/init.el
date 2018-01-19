;;;;; Use MELPA package mananger
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq custom-safe-themes t)
(setq inhibit-splash-screen t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;;; auto save to temp dir
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;;; color theme
(load-theme 'misterioso)
;;; The cursor is hard to see in misterioso; change the color
(setq default-frame-alist '((cursor-color . "#e9967a")))

;; this will set the window size if opened with a window.
;; note that emacsclient needs to be run with --frame-parameters
;; to set the window size.
(if window-system (set-frame-size (selected-frame) 170 55))

;;;; seems that a tab width of 4 is best for others
(setq c-default-style "linux" c-basic-offset 4)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(c-set-offset 'substatement-open 0)
(setq-default indent-tabs-mode nil)
(show-paren-mode 1)                  ;; Always attempt to show matching parentheses

(add-hook 'c-mode-common-hook
          (lambda()
            (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

(global-set-key "\M-`" 'next-buffer)


;; add line numbers to margin
(global-linum-mode 1)

;;; I don't like how list-buffer doesn't get focus with C-xC-b.
(global-set-key "\C-x\C-b" 'buffer-menu)

;;;; always highlight the current line
(global-hl-line-mode 1)
(set-face-background 'hl-line "#222")
(set-face-foreground 'highlight nil)
(set-face-foreground 'hl-line nil)

;;; remove trailing whitespace on save
(add-hook 'before-save-hook 'whitespace-cleanup)

(load "emacs_functions")

(provide 'init)
