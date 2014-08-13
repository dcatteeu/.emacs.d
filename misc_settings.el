;; General customizations ======================================================

;; Redefine some hard to type keybindings.
(global-set-key (kbd "M-2") 'beginning-of-buffer) ; M-<
(global-set-key (kbd "M-3") 'end-of-buffer) ; M->
(global-set-key (kbd "M-5") 'query-replace) ; M-%
(global-set-key (kbd "C-M-5") 'query-replace-regexp) ; C-M-%
(defun drc-flyspell-mode-keys ()
  "My keybindings for `flyspell-mode'."
  (define-key flyspell-mode-map (kbd "M-4") 'ispell-word)) ; M-$
(add-hook 'flyspell-mode-hook 'drc-flyspell-mode-keys)

(if window-system
    (progn ;; DC, 20140303: Disable graphical dialog boxes, they lock
	   ;; Emacs, since they don't respond to the button clicks.
      (setq use-dialog-box nil)
      ;; Turn off scroll and tool bar.
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      ;; Turn on line nbrs
      (global-linum-mode t))
  (menu-bar-mode -1)) ;turn off menu bar in text mode

;; Show column nbr.
(column-number-mode t)

;; Delete selected text when inserting.
(delete-selection-mode 1)

;; Word wrap, line-move and kill-line visual, no wrap indicator in the
;; fringes.
(global-visual-line-mode 1) 

;; Highlight entire expression between matching parentheses.
(show-paren-mode 1)
(setq show-paren-style 'expression)

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

;; Keep track of recently opened files and list them.
(recentf-mode 1)
(recentf-open-files)

;; ;; Open and show bookmark list.
;; (bookmark-bmenu-list)
;; (switch-to-buffer "*Bookmark List*")

(setq initial-scratch-message 
";;;; VARIOUS

;;                            char      word     line                
;; transpose                  C-t       M-t      C-x C-t


;;;; FIND/REPLACE
            
;; find forward               C-s       
;;      backward              C-r
;; find & replace             M-%
;;     with regex             C-M-%
;;     in dired               Q


;;;; MOVE CURSOR

;;                            begin     end      previous  next
;; line                       C-a       C-e      C-p       C-n
;; character                                     C-b       C-f
;; sentence                   M-a       M-e
;; word                       M-b       M-f
;; buffer                     M-<       M->
;; page                                          M-v       C-v

;; back to mark               C-u C-space
;; goto-line                  M-g g



;;;; S-EXPRESSIONS

;;                                 sibling
;;                            previous  next       parent    child
;; sexp                       C-M-left  C-M-right  C-M-up    C-M-down
;; list (sexps wo atoms)      C-M-p     C-M-n
;;
;; select till end of sexp    C-M-space


;;;; MARK, COPY, PASTE

;; toggle mark                C-space or M-space
;; copy region                M-w
;; paste                      C-y and M-y for previous
;; kill 
;;      region                C-w
;;      to end of line        C-k
;;      to end of sentence    M-k
;;      char left/right       backspace / C-d
;;      word left/right       M-backspace / M-d


;;;; CANCEL, UNDO

;; cancel                     C-g
;; undo                       C-/ (also C-_ or C-x u)


;;;; FILE, BUFFER (C-x)

;; open file in buffer        C-x f
;; open other file in buffer  C-x C-v
;; switch to buffer           C-x b

;; dired                      C-x d
;; list buffers               C-x C-b

;; close buffer               C-x k
;; save interactively         C-x s
;; save buffer                C-x C-s
;; save buffer as             C-x C-w
;; exit                       C-x C-c


;;;; HELP (C-h)

;; apropos                    C-h a
;; function                   C-h f
;; key-binding (full)         C-h c (C-h k)
;; info                       C-h i
")

;; Auto-saves ==================================================================

;; All backups go into 1 directory.
(setq backup-directory-alist
      `(("." . "~/.emacs.d/backups")))
