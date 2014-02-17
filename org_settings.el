(eval-after-load "org"
  '(progn
     (add-hook 'org-mode-hook 
	       (lambda ()
		 (visual-line-mode 1)
		 (toggle-word-wrap 1)))))
