;; General customizations ======================================================


;; DC, 20140303: Disable graphical dialog boxes, they lock Emacs,
;; since they don't respond to the button clicks.
(if window-system
    (setq use-dialog-box nil))

;;(column-number-mode t) ;show column nbr
(global-font-lock-mode t) ;apply syntax highlighting to all buffers

(if window-system
    (progn (scroll-bar-mode -1) ;turn off scroll bar
	   (tool-bar-mode -1) ;turn off tool bar
	   (global-linum-mode t)) ;turn on line nbrs
  (menu-bar-mode -1)) ;turn off menu bar in text mode

(show-paren-mode 1) ;show matching parentheses
(delete-selection-mode 1) ;delete selected text when inserting

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))
;; Handy key definition
(define-key global-map "\M-Q" 'unfill-paragraph)

;; Use the new way to list buffers.
(defalias 'list-buffers 'ibuffer)

;; Load (the Marmalade and) Melpa package archive.
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; Set default path from shell
;; DC, 20140320: no longer needed, I set the path through launchdctl.
;(require 'exec-path-from-shell)
;(when (memq window-system '(mac ns))
;  (exec-path-from-shell-initialize))

;; Read in DYLD_LIBRARY_PATH from .bash_profile in GUI mode.
;; DC, 20140320: only do this when lisp mode is loaded, otherwise may
;; intervene with latex-skim-forward-search.
;; (if window-system ;(not (getenv "TERM_PROGRAM"))
;;     (setenv "DYLD_LIBRARY_PATH"
;; 	    (shell-command-to-string 
;; 	     "source $HOME/.bash_profile && printf $DYLD_LIBRARY_PATH")))

;; TODO: is this still necessary? We use Melpa now.
;; set load-path to ~/.emacs.d/lisp and all subdirectories
;;(let ((default-directory "~/.emacs.d/lisp/"))
;;  (normal-top-level-add-to-load-path '("."))
;;  (normal-top-level-add-subdirs-to-load-path))

;(load "~/.emacs.d/my-graphene.el")

;; Visualisation
;(setq indicate-buffer-boundaries 'left)
;(setq indicate-empty-lines t)
;(setq visible-bell t)

;; indentation
(setq c-basic-offset 4)

;; ;; Look ========================================================================

;; ;; Set fonts before loading theme.

;; ;; Fonts
;; (setq my-default-font "Menlo-12")
;; (setq my-variable-pitch-font "Lucida Sans-12")
;; (setq my-fixed-pitch-font "Menlo-12")
;; (if window-system
;;     (progn
;;       ;; Set default frame font
;;       (add-to-list 'default-frame-alist `(font . ,my-default-font))
;;       ;; Set default, variable and fixed pitch font
;;       (set-face-font 'default my-default-font)
;;       (set-face-font 'variable-pitch my-variable-pitch-font)
;;       (set-face-font 'fixed-pitch my-fixed-pitch-font)))

;; ;; Theme
;; (if window-system
;;     (progn
;;       (setq custom-enabled-themes '(solarized-dark solarized-light))
;;       (setq custom-safe-themes
;; 	    '("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6"
;; 	      "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365"
;; 	      default))
;;       (load-theme 'solarized-light t)))



;; Autocompletion ==============================================================

;; Use Smex for recent M-x commands a la ido.
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Don't make me type out 'yes' and 'no'
(fset 'yes-or-no-p 'y-or-n-p)

;; Defaults for Ido
(setq ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-everywhere t)
(ido-mode 1)

;; Allow commands which would be disabled by default.
(put 'ido-complete 'disabled nil)
(put 'ido-exit-minibuffer 'disabled nil)

;; Bind 'C-x k' to 'kill-this-buffer. You get only prompted when the
;; buffer was modified.
(global-set-key [(control x) (k)] 'kill-this-buffer)



;; Startup =====================================================================

(setq inhibit-startup-screen t) ;Hide startup-screen. 

;; Open and show bookmark list.
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")

(setq initial-scratch-message ";; S H O R T - C U T S

;; transpose char             C-t
;; transpose word             M-t
;; transpose line             C-x C-t

;;                            begin     end
;; line                       C-a       C-e
;; paragraph                  M-a       M-e
;; word                       M-b       M-f
;; buffer                     M-<       M->

;;                            previous  next
;; line                       C-p       C-n
;; page                       M-v       C-v
;; matching parenthesis       C-M-p     C-M-n

;; toggle mark                C-space
;; back to mark               C-u C-space
;; goto-line                  M-g g
;; cancel command             C-g

;; mark                       M-SPC or C-SPC
;; kill region                C-w
;; kill to end of line        C-k
;; copy region                M-w
;; paste                      C-y and M-y for previous

;; undo                       C-_

;; open file in buffer        C-x b
;; open other file in buffer  C-x C-v
;; list buffers               C-x C-b
;; close buffer               C-x k
;; save buffer                C-x C-s
;; save buffer as             C-x C-w
;; exit                       C-x C-c

;;                            forward   backward
;; incremental search         C-s       C-r
")

;; Auto-saves ==================================================================

;; All backups go into 1 directory.
(setq backup-directory-alist
      `(("." . "~/.emacs.d/backups")))
