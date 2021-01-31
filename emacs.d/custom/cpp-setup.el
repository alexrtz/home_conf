;;; cpp-setup --- C and C++ config

;;; Commentary:

;;; Code:

(defun my-c-mode-hook()
  (defun insert-parentheses () "insert parentheses and go between them" (interactive)
    (insert "()" )
    (backward-char 1))
  (defun insert-brackets () "insert brackets and go between them" (interactive)
    (insert "[]" )
    (backward-char 1))
  (defun insert-braces () "insert curly braces and go between them" (interactive)
    (insert "{}" )
    (backward-char 1))
  (defun insert-quotes () "insert quotes and go between them" (interactive)
    (insert "\"\"" )
    (backward-char 1))
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
	;;(c-set-offset 'inline-open '+)
  (c-set-offset 'substatement-open '0)
  (c-set-offset 'brace-list-open '0)
  (c-set-offset 'statement-case-open '0)
  (c-set-offset 'case-label '0)
  ;;(c-set-offset 'statement-case-intro '+)
  (c-set-offset 'arglist-intro '+)
  ;; (c-set-offset 'arglist-cont '0)
  (c-set-offset 'arglist-close '0)
  (c-set-offset 'innamespace '0)
  (setq show-trailing-whitespace t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (flyspell-prog-mode)
)

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(use-package yasnippet)

(use-package modern-cpp-font-lock
   :config
  (modern-c++-font-lock-mode t))

(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

(use-package lsp-mode :commands lsp
  :config
  (progn
    (setq lsp-enable-file-watchers nil)
    )
  )
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(use-package ccls
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))


(provide 'cpp-setup)
;;; cpp-setup.el ends here
