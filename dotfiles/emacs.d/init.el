;;; init -- emacs initialization -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'package-archives
             '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)

(defvar my/package-refresh-timestamp-file
  (expand-file-name "package-refresh-timestamp" user-emacs-directory)
  "File to store last package refresh timestamp.")

(defun my/package-refresh-if-needed ()
  "Refresh package contents only if it hasn't been refreshed today."
  (let* ((now (current-time))
         (today (format-time-string "%Y-%m-%d" now))
         (last-refresh
          (when (file-exists-p my/package-refresh-timestamp-file)
            (with-temp-buffer
              (insert-file-contents my/package-refresh-timestamp-file)
              (buffer-string)))))
    (unless (and last-refresh (string= today last-refresh))
      (message "Refreshing package archives...")
      (package-refresh-contents)
      (with-temp-file my/package-refresh-timestamp-file
        (insert today)))))

;;(my/package-refresh-if-needed)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package protobuf-mode)
;(use-package protobuf-ts-mode)

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

;(use-package tree-sitter)
;(use-package 'tree-sitter-langs)

(defun risky-local-variable-p (sym &optional _ignored) nil)

(require 'helm-setup)
(require 'general-setup)
(require 'ui-setup)

(require 'lsp-setup)

(require 'cpp-setup)
(require 'python-setup)

(require 'container-setup)
(require 'org-setup)
(require 'setup-net-clients)
(require 'setup-spelling)
(require 'setup-various-build-systems)
(require 'setup-various-doc-formats)
(require 'setup-various-languages)
(require 'setup-vcs)

(require 'shortcuts-setup)

(setq custom-file "~/.config/mine/custom.el")
(when (file-exists-p custom-file)
  (load-file custom-file)
  )

(provide 'init)
;;; init.el ends here
