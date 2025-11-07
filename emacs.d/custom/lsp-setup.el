;; -*- lexical-binding: t; -*-


;;; lsp-setup --- lsp config

;;; Commentary:

;;; Code:

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :init
  (progn
    (setq lsp-log-io nil)
    (setq lsp-enable-file-watchers t)

    (setq lsp-file-watch-ignored-directories
          '("[/\\\\]\\.git$"
            "[/\\\\]node_modules$"
            "[/\\\\]build$"
            "[/\\\\]buck-out$"
            "[/\\\\]dist$"))

    (setq lsp-enable-on-type-formatting nil)
    (setq lsp-completion-ignore-case t)
    (setq lsp-eldoc-enable t)
    (setq lsp-diagnostics-provider :flycheck)

      (setq lsp-completion-provider :none)
      (setq lsp-eldoc-enable-hover t)
      (setq lsp-enable-symbol-highlighting t)
      (setq lsp-headerline-breadcrumb-enable t)
    )
  :config
  (lsp-enable-which-key-integration t)
  )


(add-hook 'lsp-after-apply-edits-hook
          (lambda (operation)
            (when (eq operation 'rename)
              (save-buffer))))

(use-package lsp-ui
  :commands lsp-ui-mode
  :after lsp-mode
  :init
  (progn
    (setq lsp-ui-doc-enable t)
    (setq lsp-ui-doc-position 'bottom)
    (setq lsp-ui-doc-delay 0.2)
    (setq lsp-ui-doc-show-with-cursor nil)
    (setq lsp-ui-doc-show-with-mouse nil)
    (setq lsp-ui-sideline-enable nil)
    (setq lsp-ui-sideline-show-diagnostics nil)
    (setq lsp-ui-sideline-show-hover nil)
    (setq lsp-ui-sideline-show-code-actions t)
    (setq lsp-ui-peek-enable t)
    (setq lsp-ui-imenu-enable t)
    (setq lsp-ui-imenu-kind-position 'top)
    (setq lsp-ui-flycheck-enable t)
  )
)
;; (add-hook 'c-mode-hook 'lsp)

(provide 'lsp-setup)
;;; lsp-setup.el ends here
