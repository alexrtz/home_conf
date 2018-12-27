(defun my-c-mode-hook()
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
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
	;;(c-set-offset 'inline-open '+)
  (c-set-offset 'substatement-open '0)
  (c-set-offset 'brace-list-open '0)
  (c-set-offset 'statement-case-open '0)
  (c-set-offset 'case-label '0)
  ;;(c-set-offset 'statement-case-intro '+)
  (c-set-offset 'arglist-intro '+)
  ;; (c-set-offset 'arglist-cont '0)
  (c-set-offset 'arglist-close '0)
  (c-set-offset 'innamespace '+)
  (setq show-trailing-whitespace t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  (flyspell-prog-mode)
)

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(use-package company
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (global-set-key (kbd "M-/") 'company-complete-common-or-cycle)
    (setq company-idle-delay 0)))

(use-package flycheck
  :config
  (progn
    (global-flycheck-mode)))

(use-package irony
  :config
  (progn
    ;; If irony server was never installed, install it.
    (unless (irony--find-server-executable) (call-interactively #'irony-install-server))

    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)

    ;; Use compilation database first, clang_complete as fallback.
    (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
                                                      irony-cdb-clang-complete))

    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  ))

  ;; I use irony with company to get code completion.
  (use-package company-irony
    :config
    (progn
      (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))

  ;; I use irony with flycheck to get real-time syntax checking.
  (use-package flycheck-irony
    :config
    (progn
      (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))))

  ;; Eldoc shows argument list of the function you are currently writing in the echo area.
  (use-package irony-eldoc
    :config
    (progn
      (add-hook 'irony-mode-hook #'irony-eldoc)))

(use-package rtags
  :config
  (progn
    (unless (rtags-executable-find "rc") (error "Binary rc is not installed!"))
    (unless (rtags-executable-find "rdm") (error "Binary rdm is not installed!"))

    (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
    (define-key c-mode-base-map (kbd "M-,") 'rtags-find-references-at-point)
    (define-key c-mode-base-map (kbd "M-?") 'rtags-display-summary)
    (rtags-enable-standard-keybindings)

    (setq rtags-use-helm t)

    ;; Shutdown rdm when leaving emacs.
    (add-hook 'kill-emacs-hook 'rtags-quit-rdm)
    ))

;; TODO: Has no coloring! How can I get coloring?
(use-package helm-rtags
  :config
  (progn
    (setq rtags-display-result-backend 'helm)
    ))

;; Use rtags for auto-completion.
(use-package company-rtags
  :config
  (progn
    (setq rtags-autostart-diagnostics t)
    (rtags-diagnostics)
    (setq rtags-completions-enabled t)
    (push 'company-rtags company-backends)
    ))

;; Live code checking.
(use-package flycheck-rtags
  :config
  (progn
    ;; ensure that we use only rtags checking
    ;; https://github.com/Andersbakken/rtags#optional-1
    (defun setup-flycheck-rtags ()
      (flycheck-select-checker 'rtags)
      (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
      (setq-local flycheck-check-syntax-automatically nil)
      (rtags-set-periodic-reparse-timeout 2.0)  ;; Run flycheck 2 seconds after being idle.
      )
    (add-hook 'c-mode-hook #'setup-flycheck-rtags)
    (add-hook 'c++-mode-hook #'setup-flycheck-rtags)
    ))








(use-package projectile
  :config
  (progn
    (projectile-global-mode)
    ))








;; Helm makes searching for anything nicer.
;; It works on top of many other commands / packages and gives them nice, flexible UI.
(use-package helm
  :config
  (progn
    (require 'helm-config)

    ;; Use C-c h instead of default C-x c, it makes more sense.
    (global-set-key (kbd "C-c h") 'helm-command-prefix)
    (global-unset-key (kbd "C-x c"))

    (setq
     ;; move to end or beginning of source when reaching top or bottom of source.
     helm-move-to-line-cycle-in-source t
     ;; search for library in `require' and `declare-function' sexp.
     helm-ff-search-library-in-sexp t
     ;; scroll 8 lines other window using M-<next>/M-<prior>
     helm-scroll-amount 8
     helm-ff-file-name-history-use-recentf t
     helm-echo-input-in-header-line t)

    (global-set-key (kbd "M-x") 'helm-M-x)
    (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

    (global-set-key (kbd "C-x C-f") 'helm-find-files)

    (global-set-key (kbd "M-y") 'helm-show-kill-ring)

    (global-set-key (kbd "C-x b") 'helm-mini)
    (setq helm-buffers-fuzzy-matching t
          helm-recentf-fuzzy-match t)

    ;; TOOD: helm-semantic has not syntax coloring! How can I fix that?
    (setq helm-semantic-fuzzy-match t
          helm-imenu-fuzzy-match t)

    ;; Lists all occurences of a pattern in buffer.
    (global-set-key (kbd "C-c h o") 'helm-occur)

    (global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)

    ;; open helm buffer inside current window, not occupy whole other window
    (setq helm-split-window-in-side-p t)
    (setq helm-autoresize-max-height 50)
    (setq helm-autoresize-min-height 30)
    (helm-autoresize-mode 1)

    (helm-mode 1)
    ))

;; Use Helm in Projectile.
(use-package helm-projectile
;  :require helm projectile
  :config
  (progn
    (setq projectile-completion-system 'helm)
    (helm-projectile-on)
    ))


;; (use-package cedet)

;; (semantic-mode t)
;; (require 'semantic/ia)
;; (require 'semantic/bovine/gcc)
;; (semantic-add-system-include "/usr/include/boost" 'c++-mode)
;; (semantic-add-system-include "/usr/include/x86_64-linux-gnu/qt5/" 'c++-mode)
;; (require 'semantic/db)
;; (global-semanticdb-minor-mode t)
;; (global-semantic-highlight-func-mode t)
;; (global-semantic-decoration-mode t)
;; (global-semantic-idle-local-symbol-highlight-mode t)
;; (global-semantic-idle-scheduler-mode t)
;; (global-semantic-idle-completions-mode t)
;; (require 'semantic/db-global)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)
;; ;(semantic-load-enable-primary-exuberent-ctags-support)

;; (global-ede-mode t)

;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)

;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))

;; ;(when (cedet-ectag-version-check)
;; ;  (semantic-load-enable-primary-exuberent-ctags-support))

;; (defun my-cedet-hook ()
;;   (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;;   (local-set-key [backtab] 'semantic-ia-complete-symbol-menu)
;;   (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;   (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
;;   ;;(local-set-key "." 'semantic-complete-self-insert)
;;   ;;(local-set-key ">" 'semantic-complete-self-insert)
;;   (local-set-key [f12] 'semantic-complete-jump)
;;   (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))

;; (add-hook 'c++-mode-common-hook 'my-cedet-hook)
;; (add-hook 'c-mode-common-hook 'my-cedet-hook)

;; (if (file-exists-p "~/.emacs.d/ede-projects")
;;     (load-file "~/.emacs.d/ede-projects"))


;; (when (require 'ecb nil 'noerror)
;;   (add-to-list 'load-path "~/.emacs.d/ecb")
;;   (require 'ecb)
;;   (require 'ecb-autoloads)
;;   (setq ecb-auto-activate nil)
;;   (setq ecb-tip-of-the-day nil)
;;   (setq ecb-display-news-for-upgrade nil)
;;   (setq ecb-windows-width 0.2))


;; (defun my-c-mode-hook()
;;   (defun insert-parentheses () "insert parentheses and go between them" (interactive)
;;     (insert "()" )
;;     (backward-char 1))
;;   (defun insert-brackets () "insert brackets and go between them" (interactive)
;;     (insert "[]" )
;;     (backward-char 1))
;;   (defun insert-braces () "insert curly braces and go between them" (interactive)
;;     (insert "{}" )
;;     (backward-char 1))
;;   (defun insert-quotes () "insert quotes and go between them" (interactive)
;;     (insert "\"\"" )
;;     (backward-char 1))
;;   (setq c-basic-offset 2)
;;   (setq indent-tabs-mode nil)
;;   (setq tab-width 2)
;; 	;;(c-set-offset 'inline-open '+)
;;   (c-set-offset 'substatement-open '0)
;;   (c-set-offset 'brace-list-open '0)
;;   (c-set-offset 'statement-case-open '0)
;;   (c-set-offset 'case-label '+)
;;   ;;(c-set-offset 'statement-case-intro '+)
;;   ;;(c-set-offset 'arglist-intro '+)
;;   ;; (c-set-offset 'arglist-cont '0)
;;   ;; (c-set-offset 'arglist-close '+)
;;   (c-set-offset 'innamespace '+)
;;   (setq show-trailing-whitespace t)
;;   (add-hook 'before-save-hook 'delete-trailing-whitespace)
;;   ;; (flyspell-prog-mode)
;; )

;; (add-hook 'c-mode-hook 'my-c-mode-hook)
;; (add-hook 'c++-mode-hook 'my-c-mode-hook)

;; (defun inside-class-enum-p (pos)
;;   "Checks if POS is within the braces of a C++ \"enum class\"."
;;   (ignore-errors
;;     (save-excursion
;;       (goto-char pos)
;;       (up-list -1)
;;       (backward-sexp 1)
;;       (looking-back "enum[ \t]+class[ \t]+[^}]+"))))

;; (defun align-enum-class (langelem)
;;   (if (inside-class-enum-p (c-langelem-pos langelem))
;;       0
;;     (c-lineup-topmost-intro-cont langelem)))

;; (defun align-enum-class-closing-brace (langelem)
;;   (if (inside-class-enum-p (c-langelem-pos langelem))
;;       '-
;;     '+))

;; (defun fix-enum-class ()
;;   "Setup `c++-mode' to better handle \"class enum\"."
;;   (add-to-list 'c-offsets-alist '(topmost-intro-cont . align-enum-class))
;;   (add-to-list 'c-offsets-alist
;;                '(statement-cont . align-enum-class-closing-brace)))

;; (add-hook 'c++-mode-hook 'fix-enum-class)

;; (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;; (add-to-list 'auto-mode-alist '("\\.hxx\\'" . c++-mode))
;; (add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))

;; ;; TODO AOR: clean this
;; (global-set-key [C-f5] 'gud-cont)
;; (global-set-key [C-f9] 'gud-break)
;; (global-set-key [C-f10] 'gud-next)
;; (global-set-key [C-f11] 'gud-step)

;; ;; TODO AOR: what is this for?
;; (load-file "~/.emacs.d/lisp/gprof-mode.el")
;; (require 'gprof)
;; (setq auto-mode-alist (cons '("\\.gprof\\w?" . gprof-mode) auto-mode-alist))


;; (setq compile-command "LC_MESSAGES=C make -j5")
;; (setq compilation-read-command nil)

;; (use-package smart-compile)

;; (global-set-key [f6] 'smart-compile)
;; (global-set-key [f7] 'next-error)

;; ;(global-set-key [f7] 'compile-goto-error-and-close-compilation-window)
;; ;(setq compilation-window-height 15)

;; ;; (setq compilation-finish-function
;; ;;       (lambda (buf str)

;; ;;         (if (string-match "exited abnormally" str)

;; ;;             ;;there were errors
;; ;;             (message "compilation errors, press C-x ` to visit")

;; ;;           ;;no errors, make the compilation window go away in 0.5 seconds
;; ;; ;          (run-at-time 0.5 nil 'delete-windows-on buf)
;; ;;           (run-at-time 0.5 nil 'kill-buffer buf)
;; ;;           (message "NO COMPILATION ERRORS!"))))


;; ;; (setq compilation-finish-function
;; ;;       (lambda (buf str)
;; ;;         (if (string-match "*Ack-and-a-half*" (buffer-name))
;; ;;             (if (string-match "exited abnormally" str)
;; ;;                 (run-at-time 0.5 nil 'kill-buffer buf)
;; ;;                  )
;; ;;         (if (string-match "exited abnormally" str)
;; ;;             (message "compilation errors, press C-x ` to visit")
;; ;;           ; else
;; ;;           ((run-at-time 0.5 nil 'kill-buffer buf)
;; ;;           (message "NO COMPILATION ERRORS!"))
;; ;;           ) ; (string-match "exited abnormally" str)
;; ;;         )))

;;   ;; Close the compilation window if there was no error at all.
;; (setq compilation-exit-message-function
;;       (lambda (status code msg)
;;         ;; If M-x compile exists with a 0
;;         (when (and (eq status 'exit) (zerop code) (not (string-match "*Ack-and-a-half*" (buffer-name))))
;;           ;; then bury the *compilation* buffer, so that C-x b doesn't go there
;;   	  (bury-buffer "*compilation*")
;;   	  ;; and return to whatever were looking at before
;;   	  (replace-buffer-in-windows "*compilation*"))
;;         ;; Always return the anticipated result of compilation-exit-message-function
;;   	(cons msg code)))


;; ;; (setq compilation-finish-function
;; ;;       (lambda (buf str)

;; ;;         (if (and (string-match "exited abnormally" str)
;; ;;             (string-match "*Ack-and-a-half*" (buffer-name)))
;; ;;             ((run-at-time 0.5 nil 'kill-buffer buf)
;; ;;           (message "NO COMPILATION ERRORS!"))

;; ;;             ;;there were errors
;; ;;             (message "compilation errors, press C-x ` to visit")

;; ;;           ;;no errors, make the compilation window go away in 0.5 seconds
;; ;; ;          (run-at-time 0.5 nil 'delete-windows-on buf)
;; ;;           )))


;; ;; (defun bury-compile-buffer-if-successful (buffer string)
;; ;;   "Bury a compilation buffer if succeeded without warnings "
;; ;;   (if (and
;; ;;        (with-current-buffer buffer
;; ;;           (search-forward "xcolor" nil t))
;; ;;        (not
;; ;;         (with-current-buffer buffer
;; ;;           (search-forward "wazaaabi" nil t))))
;; ;;       (run-with-timer 1 nil
;; ;;                       (lambda (buf)
;; ;;                         (bury-buffer buf)
;; ;;                         (switch-to-prev-buffer (get-buffer-window buf) 'kill))
;; ;;                       buffer)))
;; ;; (add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)

(provide 'setup-cpp)
