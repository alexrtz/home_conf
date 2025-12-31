;; setup-various-doc-formats --- Some documentation formats configuration  -*- lexical-binding: t; -*-

;;; Commentary:


;;; Code:


(use-package json-mode
  :config
  (setq
	 show-trailing-whitespace t
	 indent-tabs-mode nil)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
)

;; LaTeX

;(use-package auctex)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;; Markdown

(use-package markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(defun my-markdown-hook ()
  (setq show-trailing-whitespace t)
  (setq indent-tabs-mode nil)
  (remove-hook 'before-save-hook 'delete-trailing-whitespace)
 )

(add-hook 'markdown-mode-hook 'my-markdown-hook)
(add-hook 'markdown-mode-hook 'flyspell-mode)

;; XML

(defun my-nxml-hook ()
 (setq show-trailing-whitespace t)
 (setq indent-tabs-mode nil)
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
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.clang-tidy$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.clang-format$" . yaml-mode))


(provide 'setup-various-doc-formats)
;;; setup-various-doc-formats.el ends here
