(eval-after-load "text"
  '(add-hook 'text-mode-hook 
	     (lambda ()
	       (setq word-wrap t))))
