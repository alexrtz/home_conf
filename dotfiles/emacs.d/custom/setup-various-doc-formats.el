;; setup-various-doc-formats --- Some documentation formats configuration  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun my-json-hook ()
  (setq show-trailing-whitespace t)
	(setq indent-tabs-mode nil)
  (setq js-indent-level 4)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  )

(use-package json-mode
  :hook (json-mode . my-json-hook)
)


;; LaTeX

;(use-package auctex)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

;; Typst

(use-package typst-ts-mode
  :mode "\\.typ\\'"
  :hook ((typst-ts-mode . flyspell-mode)
         (typst-ts-mode . eglot-ensure))
  :config
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(typst-ts-mode . ("tinymist")))))

(add-to-list 'treesit-language-source-alist
             '(typst "https://github.com/uben0/tree-sitter-typst"))

(unless (treesit-language-available-p 'typst)
  (cl-letf (((symbol-function 'y-or-n-p) (lambda (&rest _) t)))
    (treesit-install-language-grammar 'typst)))

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
