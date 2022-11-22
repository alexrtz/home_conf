;;; init -- emacs initialization

;;; Commentary:

;;; Code:

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package tramp
  :config
  (progn
    (setq tramp-terminal-type "tramp")
    (setq tramp-verbose 6)
    ))

(add-to-list 'load-path "~/.emacs.d/custom")
; TODO: use use-package for revive
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/mine")

(defun risky-local-variable-p (sym &optional _ignored) nil)

(require 'helm-setup)
(require 'general-setup)
(require 'ui-setup)
(require 'cpp-setup)

(require 'setup-net-clients)
(require 'setup-org)
(require 'setup-spelling)
(require 'setup-various-build-systems)
(require 'setup-various-doc-formats)
(require 'setup-various-languages)
(require 'setup-vcs)

(require 'shortcuts-setup)

(let ((local-settings "~/.config/mine/local-settings.el"))
 (when (file-exists-p local-settings)
   (load-file local-settings))
 )

(setq custom-file "~/.config/mine/custom.el")
(load custom-file)

(provide 'init)
;;; init.el ends here
