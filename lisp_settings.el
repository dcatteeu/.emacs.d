(add-to-list 'auto-mode-alist '("\\.lisp$" . lisp-mode))

(load (expand-file-name "~/quicklisp/slime-helper.el"))

(setq inferior-lisp-program 
      "/usr/local/bin/sbcl"
      common-lisp-hyperspec-root
      "file:/Users/dcatteeu/Documents/Common Lisp HyperSpec 7.0/HyperSpec/")

;; So that gsll can find libgslcblas.dylb in /usr/local/lib.
(if (not (getenv "TERM_PROGRAM"))
    (setenv "DYLD_LIBRARY_PATH" 
	    (concat "/usr/local/lib:"
		    (shell-command-to-string 
		     "echo $DYLD_LIBRARY_PATH"))))

(eval-after-load "lisp"
  '(add-hook 'lisp-mode-hook
	     (lambda ()
	       (setq fill-column 90)
	       (c-toggle-hungry-state 1) ;kill whitespace greedily
	       (c-toggle-electric-state 1)))) ;special chars trigger indentation
