;; -*- lexical-binding: t; -*-


;;; lsp-setup --- lsp config

;;; Commentary:

;;; Code:

(use-package lsp-mode :commands lsp
  :config
  (progn
    (setq lsp-enable-file-watchers nil)
    (setq lsp-enable-on-type-formatting nil)
    (setq lsp-completion-ignore-case t)
    )
  )

(add-hook 'lsp-after-apply-edits-hook
          (lambda (operation)
            (when (eq operation 'rename)
              (save-buffer))))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (progn
    (setq lsp-ui-doc-enable t)
    (setq lsp-ui-imenu-enable t)
    (setq lsp-ui-peek-enable nil)
    (setq lsp-ui-sideline-enable nil)))

;; (add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(provide 'lsp-setup)
;;; lsp-setup.el ends here
