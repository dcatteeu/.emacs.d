;;;; Tex mode

(defun drc-default-bibtex ()
  (cdr (assoc system-type
	      '(("darwin" . ("/Users/dcatteeu/Research/Papers/library"))
		("gnu/linux" . ())
		("windowns-nt" . ())))))

(setq-default TeX-PDF-mode t)
(setq-default TeX-master nil)
(setq latex-run-command "pdflatex")
;(setq tex-shell-file-name nil)

(defun drc-auctex-latex ()
  (interactive)
  (save-buffer)
  (TeX-command "LaTeX" 'TeX-master-file 0))

(defun drc-auctex-bibtex ()
  (interactive)
  (TeX-command "BibTex" 'TeX-master-file 0))

(defun drc-auctex-mk ()
  (interactive)
  (save-buffer)
  (TeX-command "Mk" 'TeX-master-file 0))

(defun drc-auctex-view ()
  (interactive)
  (TeX-command "View" 'TeX-master-file 0))

(defun drc-auctex-clean ()
  (interactive)
  (TeX-command "Clean" 'TeX-master-file))

(defun drc-LaTeX-mode-keys ()
  "Modify keymaps used by `LaTeX-mode'."
  (local-set-key (kbd "<f5>") 'drc-auctex-latex)
  (local-set-key (kbd "<f6>") 'drc-auctex-bibtex)
  (local-set-key (kbd "<f7>") 'drc-auctex-mk)
  (local-set-key (kbd "<f8>") 'drc-auctex-view)
  (local-set-key (kbd "<f9>") 'drc-auctex-clean))

;; (defun drc-reftex-format-cref (label format reftex-refstyle)
;;   (format "\\Cref{%s}" label))

(eval-after-load "tex"
  '(progn
     (add-hook 'LaTeX-mode-hook 'drc-LaTeX-mode-keys)
     (add-hook 'LaTeX-mode-hook 'visual-line-mode)
     (add-hook 'LaTeX-mode-hook 'flyspell-mode)
     (add-hook 'LaTeX-mode-hook 'linum-mode)
     (setq TeX-auto-save t)
     ;(setq TeX-parse-self t)
     (setq TeX-show-compilation t)
     (setq LaTeX-command "latex")
     ;; Synchronization between Emacs and PDF viewer
     (setq TeX-source-correlate-method 'synctex)
     (setq TeX-source-correlate-mode t)
     (setq TeX-source-correlate-start-server t)
     ;; RefTex
     (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
     (setq reftex-plug-into-AUCTeX t)
     (setq reftex-cite-format 'natbib)
     (setq reftex-default-bibliography 'drc-default-bibtex)
     ;; (TeX-add-style-hook "cleveref"
     ;; 			 (lambda ()
     ;; 			   (if (boundp 'reftex-ref-style-alist)
     ;; 			       (add-to-list
     ;; 				'reftex-ref-style-alist
     ;; 				'("Cleveref" "cleveref"
     ;; 				  (("\\cref" ?c) ("\\Cref" ?C)
     ;; 				   ("\\cpageref" ?d) ("\\Cpageref" ?D)))))
     ;; 			   (add-to-list 'reftex-ref-style-default-list
     ;; 					"Cleveref")
     ;; 			   (TeX-add-symbols
     ;; 			    '("cref" TeX-arg-ref)
     ;; 			    '("Cref" TeX-arg-ref)
     ;; 			    '("cpageref" TeX-arg-ref)
     ;; 			    '("Cpageref" TeX-arg-ref))))
     ;; (add-to-list 'reftex-ref-style-alist ;Add cleverefs to reftex.
     ;; 		  '("Cleveref" "cleveref" (("\\cref" ?c) ("\\Cref" ?C))))
     ;; Extra Auctex commands: Mk, Glossary, and View which now uses
     ;; skim.
     (add-to-list 'TeX-command-list
		  '("Glossary" "makeglossaries %s" TeX-run-command nil
		    (latex-mode)
		    :help "Create glossaries"))
     ;; DC, 20140303: installed auctex-latexmk to add the command
     ;; automatically.
     (add-to-list 'TeX-command-list
		  '("Mk" "latexmk -pdflatex=\"%`%l%(mode)\" %s"
		    TeX-run-command nil (latex-mode) 
		    :help "Auto run all necessary processing by
		    means of latexmk"))
     (add-to-list 'TeX-view-program-list
		  '("skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -o %n %o %b"))
     (setq TeX-view-program-selection '((output-pdf "skim")))))


;; (eval-after-load
;;     "latex"
;;   '(TeX-add-style-hook
;;     "cleveref"
;;     (lambda ()
;;       (if (boundp 'reftex-ref-style-alist)
;;       (add-to-list
;;        'reftex-ref-style-alist
;;        '("Cleveref" "cleveref"
;;          (("\\cref" ?c) ("\\Cref" ?C) ("\\cpageref" ?d) ("\\Cpageref" ?D)))))
;;       (add-to-list 'reftex-ref-style-default-list "Cleveref")
;;       (TeX-add-symbols
;;        '("cref" TeX-arg-ref)
;;        '("Cref" TeX-arg-ref)
;;        '("cpageref" TeX-arg-ref)
;;        '("Cpageref" TeX-arg-ref)))))
