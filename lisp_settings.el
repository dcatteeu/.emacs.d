(add-to-list 'auto-mode-alist '("\\.lisp$" . lisp-mode))

(load (expand-file-name "~/quicklisp/slime-helper.el"))

(setq inferior-lisp-program 
      "/usr/local/bin/sbcl"
      common-lisp-hyperspec-root
      "file:/Users/dcatteeu/Documents/Common Lisp HyperSpec 7.0/HyperSpec/")

(eval-after-load "lisp"
  '(add-hook 'lisp-mode-hook
	     (lambda ()
	       (setq fill-column 90)
	       ;; kill whitespace greedily 
	       (c-toggle-hungry-state 1) 
	       ;; special chars trigger indentation
	       (c-toggle-electric-state 1)
	       ;; So that gsll can find libgslcblas.dylb in
	       ;; /usr/local/lib/.  Make sure this is only done when
	       ;; in lisp mode. It has been made Latex->Skim forward
	       ;; search impossible before.
	       (setenv "DYLD_LIBRARY_PATH" "/usr/local/lib:")))) 
