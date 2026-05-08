;;; tools-setup --- Conf for some tools  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package copilot
  :ensure t
  :defer t
  :hook (prog-mode . copilot-mode)
  :config
  (unless (file-exists-p
           (expand-file-name
            "lib/node_modules/@github/copilot-language-server/dist/language-server.js"
            copilot-install-dir))
    (copilot-install-server))
  (defun my/copilot-accept ()
    (interactive)
    (copilot-accept-completion))
  (global-set-key (kbd "C-S-<tab>")       #'my/copilot-accept)
  (global-set-key (kbd "C-<iso-lefttab>") #'my/copilot-accept)
  )

(provide 'tools-setup)
;;; tools-setup.el ends here
