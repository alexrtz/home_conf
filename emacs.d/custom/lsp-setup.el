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

    ;; Generated with ChatGPT to move the errors at the bottom of the window
    ;; TODO AOR: does not work as expected
    ;; Disable sideline popups if you just want echo area
    ;; (setq lsp-ui-sideline-enable nil)
    ;; (setq lsp-ui-doc-enable nil)
    ;; ;; Show diagnostics in minibuffer/echo area
    ;; (setq lsp-ui-sideline-show-diagnostics nil)
    ;; (setq lsp-ui-sideline-show-hover nil)
    ;; ;; This shows diagnostic in minibuffer when point is on a problem
    ;; (setq lsp-ui-sideline-show-code-actions nil)
    ;; End of the section generated with ChatGPT to move the errors at the bottom
    ;; of the window
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

(provide 'lsp-setup)
;;; lsp-setup.el ends here
