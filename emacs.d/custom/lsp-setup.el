;;; lsp-setup --- lsp config

;;; Commentary:

;;; Code:

(use-package lsp-mode :commands lsp
  :config
  (progn
    (setq lsp-enable-file-watchers nil)
    (setq lsp-enable-on-type-formatting nil)
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


(provide 'lsp-setup)
;;; lsp-setup.el ends here
