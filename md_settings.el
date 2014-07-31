(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(eval-after-load "markdown"
  '(add-hook 'markdown-mode-hook 'flyspell-mode))
