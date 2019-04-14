;; General


(modify-coding-system-alist 'file "\\.php$" 'utf-8)
(modify-coding-system-alist 'file "\\.plant$" 'utf-8)
(modify-coding-system-alist 'file "\\.py$" 'utf-8)
(modify-coding-system-alist 'file "\\.csv$" 'utf-8)
(modify-coding-system-alist 'file "\\.tex$" 'utf-8)
(modify-coding-system-alist 'file "\\.rb$" 'utf-8)
(modify-coding-system-alist 'file "\\.yaml$" 'utf-8)
(modify-coding-system-alist 'file "\\.yml$" 'utf-8)
(modify-coding-system-alist 'file "\\.sql$" 'utf-8)


;; CoffeeScript

(defun my-coffee-mode-hook()
  (setq tab-width 4)
  )

(add-hook 'coffee-mode-hook 'my-coffee-mode-hook)


;; CSS

(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

(defun my-css-mode-hook()
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
  (setq indent-tabs-mode -1)
  (setq show-trailing-whitespace t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (setq css-indent-offset 2)
)

(add-hook 'css-mode-hook 'my-css-mode-hook)

;; Lisp

(defun my-lisp-mode-hook()
  (setq indent-tabs-mode nil)
  )

(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-hook)


;; Python
;; TODO AOR: is there a package for this package?
(add-to-list 'load-path "~/.emacs.d/highlight-indentation")
(require 'highlight-indentation)

(defun my-python-mode-hook()
  (set-face-background 'highlight-indentation-face "#ffcc99")
  (set-face-background 'highlight-indentation-current-column-face "#24a076")
  (highlight-indentation-mode)
  ;;(setq show-trailing-whitespace t)
  ;;(setq whitespace-style '(trailing tabs newline tab-mark newline-mark))
  )

(add-hook 'python-mode-hook 'my-python-mode-hook)

;;  Rust

(use-package rust-mode)

;; Shell

(add-hook 'sh-mode-hook (lambda () (setq indent-tabs-mode t)))

(add-to-list 'auto-mode-alist '("\\.bats$" . shell-script-mode))

;; Yasnippet
(use-package yasnippet)
(use-package yasnippet-snippets)
(yas-global-mode 1)

(provide 'setup-various-languages)
