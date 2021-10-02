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

(add-to-list 'load-path "~/.emacs.d/custom")
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

; ---- language-env end DON'T MODIFY THIS LINE!
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes '(sanityinc-solarized-dark))
 '(custom-safe-themes
	 '("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default))
 '(dta-default-cfg "default.conf")
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons 'mouse-1--C-mouse-1)
 '(ecb-tree-indent 1)
 '(ecb-windows-width 0.2)
 '(inhibit-startup-screen t)
 '(package-selected-packages
	 '(scala-mode company-ledger flycheck-ledger ledger-import ledger-mode ccls lsp-clangd eglot projectile company-irony company-irony-c-headers flycheck company helm helm-ack magit yasnippet-snippets yaml-mode use-package solarized-theme smart-compile rust-mode restclient markdown-mode iedit egg dockerfile-mode color-theme-solarized color-theme-sanityinc-solarized cmake-mode autopair auto-complete ack))
 '(safe-local-variable-values
	 '((compile-command . "make -j -C `pwd`/build/")
		 (compile-command . "make -j -C /home/alex/Prog/Projets/debugz/build/")
		 (compile-command "make -j -C /home/alex/Prog/Projets/debugz/build/")
		 (compile-command "make -j -C $PWD/build/")
		 (compile-command . "make -j -C `pwd`/build")))
 '(show-paren-mode t)
 '(warning-suppress-log-types '((comp) (comp) (comp)))
 '(warning-suppress-types '((use-package) (use-package) (comp) (comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
