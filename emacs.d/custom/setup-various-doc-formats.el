;; LaTeX

(add-hook 'LaTeX-mode-hook 'flyspell-mode)


;; Markdown

(use-package markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(defun my-markdown-hook ()
  (setq show-trailing-whitespace t)
  (remove-hook 'before-save-hook 'delete-trailing-whitespace)
  (setq indent-tabs-mode nil)
  )

(add-hook 'markdown-mode-hook 'my-markdown-hook)
(add-hook 'markdown-mode-hook 'flyspell-mode)


;; YAML

(use-package yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(provide 'setup-various-doc-formats)
