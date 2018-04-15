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

;; XML

(defun my-nxml-hook ()
 (setq show-trailing-whitespace t)
 (setq indent-tabs-mode 1)
 (setq
  nxml-child-indent 2
  nxml-attribute-indent 2
  nxml-slash-auto-complete-flag t)

 (defun insert-quotes () "insert quotes and go between them" (interactive)
        (insert "\"\"" )
        (backward-char 1))

 (add-hook 'before-save-hook 'delete-trailing-whitespace)
)

(add-hook 'nxml-mode-hook 'my-nxml-hook)

;; YAML

(use-package yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(provide 'setup-various-doc-formats)
