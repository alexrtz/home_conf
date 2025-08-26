;; -*- lexical-binding: t; -*-

;;; package -- summary

;;; Commentary:

;;; Code:


;(add-to-list 'load-path "~/.emacs.d/highlight-indentation")
                                        ;(require 'highlight-indentation)
(use-package highlight-indentation
  :ensure t)

(use-package lsp-pyright
  :if (executable-find "pyright")
  :ensure t
  :after lsp-mode
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp)
                         )
                     )
  )


(defun my-python-mode-hook()
  (set-face-background 'highlight-indentation-face "#ffcc99")
  (set-face-background 'highlight-indentation-current-column-face "#24a076")
  (highlight-indentation-mode t)
  ;;(setq show-trailing-whitespace t)
  ;;(setq whitespace-style '(trailing tabs newline tab-mark newline-mark))
  )

(add-hook 'python-mode-hook 'my-python-mode-hook)

(provide 'python-setup)
;;; python-setup.el ends here
