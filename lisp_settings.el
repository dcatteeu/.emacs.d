(add-to-list 'auto-mode-alist '("\\.lisp$" . lisp-mode))

(load (expand-file-name "~/quicklisp/slime-helper.el"))

(setq inferior-lisp-program 
      "/usr/local/bin/sbcl"
      common-lisp-hyperspec-root
      "file:/Users/dcatteeu/Documents/Common Lisp HyperSpec 7.0/HyperSpec/")

(eval-after-load "lisp"
  '(add-hook 'lisp-mode-hook
	     (lambda ()
	       (setq fill-column 90 
		     slime-autodoc-use-multiline-p t)
	       ;; kill whitespace greedily 
	       (c-toggle-hungry-state 1) 
	       ;; special chars trigger indentation
	       (c-toggle-electric-state 1)
	       ;; So that dash-at-point lookup is refined to Common
	       ;; Lisp docset.
	       (add-to-list 'dash-at-point-mode-alist
			    '(lisp-mode . "lisp")))))
