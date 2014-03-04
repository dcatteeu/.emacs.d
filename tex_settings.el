;;;; Tex mode

(setq-default TeX-master nil)
(setq latex-run-command "pdflatex")
(setq tex-shell-file-name nil)
(setq TeX-PDF-mode t)

(eval-after-load "tex" ;; TODO: put as much commands as possible in here.
  '(progn
     ;; (require 'auctex-latexmk)
     ;; (auctex-latexmk-setup)
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
     ;; Viewers
     (setq TeX-view-program-list
	   '(("Preview" "open %o")
	     ("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")))
     (setq TeX-view-program-selection
	   '(((output-dvi style-pstricks) "dvips and gv")
	     (output-dvi "Skim")
	     (output-pdf "Skim")
	     (output-html "xdg-open")))
     (setq TeX-output-view-style
	   '(("^pdf$" "." "skim %n %o %b")
	     ("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$")
	      "%(o?)dvips -t landscape %d -o && gv %f")
	     ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$"
	      "%(o?)dvips %d -o && gv %f")
	     ("^dvi$" ("^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$"
		       "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d")
	     ("^dvi$" "^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$"
	      "%(o?)xdvi %dS -paper a4 %d")
	     ("^dvi$" ("^\\(?:a5\\(?:comb\\|paper\\)\\)$" "^landscape$")
	      "%(o?)xdvi %dS -paper a5r -s 0 %d")
	     ("^dvi$" "^\\(?:a5\\(?:comb\\|paper\\)\\)$"
	      "%(o?)xdvi %dS -paper a5 %d")
	     ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d")
	     ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d")
	     ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d")
	     ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d")
	     ("^dvi$" "." "%(o?)xdvi %dS %d")
	     ("^pdf$" "." "xpdf -remote %s -raise %o %(outpage)")
	     ("^html?$" "." "netscape %o")))
     ;; Commands
     (setq TeX-command-list
	   '(("TeX" "%(PDF)%(tex) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX
	      nil (plain-tex-mode texinfo-mode ams-tex-mode)
	      :help "Run plain TeX")
	     ("LaTeX" "%`%l%(mode)%' %t" TeX-run-TeX nil
	      (latex-mode doctex-mode) :help "Run LaTeX")
	     ("Makeinfo" "makeinfo %t" TeX-run-compile nil (texinfo-mode)
	      :help "Run Makeinfo with Info output")
	     ("Makeinfo HTML" "makeinfo --html %t" TeX-run-compile nil
	      (texinfo-mode) :help "Run Makeinfo with HTML output")
	     ("AmSTeX" "%(PDF)amstex %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX
	      nil (ams-tex-mode) :help "Run AMSTeX")
	     ("ConTeXt" "texexec --once --texutil %(execopts)%t" TeX-run-TeX
	      nil (context-mode) :help "Run ConTeXt once")
	     ("ConTeXt Full" "texexec %(execopts)%t" TeX-run-TeX
	      nil (context-mode) :help "Run ConTeXt until completion")
	     ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
	     ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
	     ("Print" "%p" TeX-run-command t t :help "Print the file")
	     ("Queue" "%q" TeX-run-background nil t
	      :help "View the printer queue" :visible TeX-queue-command)
	     ("File" "%(o?)dvips %d -o %f " TeX-run-command t t
	      :help "Generate PostScript file")
	     ("Index" "makeindex %s" TeX-run-command nil t
	      :help "Create index file")
	     ("Check" "lacheck %s" TeX-run-compile nil (latex-mode)
	      :help "Check LaTeX file for correctness")
	     ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t
	      :help "Spell-check the document")
	     ("Clean" "TeX-clean" TeX-run-function nil t
	      :help "Delete generated intermediate files")
	     ("Clean All" "(TeX-clean t)" TeX-run-function nil t
	      :help "Delete generated intermediate and output files")
	     ("Other" "" TeX-run-command t t
	      :help "Run an arbitrary command")
	     ("Glossary" "makeglossaries %s" TeX-run-command nil (latex-mode)
	      :help "Create glossaries")
	     ;; DC, 20140303: installed auctex-latexmk to add the
	     ;; command automatically.  
	     ("Mk" "latexmk -pdflatex=\"%`%l%(mode)\" %s"
	      TeX-run-command nil (latex-mode) 
	      :help "Auto run all necessary processing by means
	      of latexmk") ))))
