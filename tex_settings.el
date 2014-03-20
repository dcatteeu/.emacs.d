;;;; Tex mode


(setq-default TeX-PDF-mode t)
(setq-default TeX-master nil)
(setq latex-run-command "pdflatex")
(setq tex-shell-file-name nil)

(eval-after-load "tex"
  '(progn
     (add-hook 'LaTeX-mode-hook 'visual-line-mode)
     (add-hook 'LaTeX-mode-hook 'flyspell-mode)
     (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
     (add-hook 'LaTeX-mode-hook 'linum-mode)
     (setq TeX-auto-save t)
     (setq TeX-parse-self t)
     (setq TeX-clean-confirm nil)
     (setq TeX-show-compilation t)
     (setq LaTeX-command "latex")
     ;; In-Emacs preview
     (setq preview-preserve-counters t)
     ;; Synchronization between Emacs and PDF viewer
     (setq TeX-source-correlate-method 'synctex)
     (setq TeX-source-correlate-mode t)
     (setq TeX-source-correlate-start-server t)
     ;; RefTex
     (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
     (setq reftex-plug-into-AUCTeX t)
     (setq reftex-cite-format 'natbib)
     (setq reftex-default-bibliography
	   '("/Users/dcatteeu/Papers/library"))
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
		    :help "Auto run all necessary processing by means of latexmk"))
     (add-to-list 'TeX-view-program-list
		  '("skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -o %n %o %b"))
     (setq TeX-view-program-selection '((output-pdf "skim")))))
