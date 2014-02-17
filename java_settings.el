(require 'malabar-mode)
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

(eval-after-load "java"
  '(add-hook 'java-mode-hook 
	     (lambda ()
	       (setq fill-column 90) ;wrap at column 90
	       (subword-mode 1) ;CamelCase sensitive movement
	       (c-toggle-syntactic-indentation 1) ;context-based indentation
	       (setq c-basic-offset 4) ;4 spaces
	       (c-toggle-hungry-state 1) ;kill whitespace greedily
	       (c-toggle-electric-state 1)))) ;special chars trigger indentation
