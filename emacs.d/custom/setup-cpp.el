(use-package cedet)

(semantic-mode t)
(require 'semantic/ia)
(require 'semantic/bovine/gcc)
(semantic-add-system-include "/usr/include/boost" 'c++-mode)
(require 'semantic/db)
(global-semanticdb-minor-mode t)
(global-semantic-highlight-func-mode t)
(global-semantic-decoration-mode t)
(global-semantic-idle-local-symbol-highlight-mode t)
(global-semantic-idle-scheduler-mode t)
(global-semantic-idle-completions-mode t)
(require 'semantic/db-global)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
;(semantic-load-enable-primary-exuberent-ctags-support)

(global-ede-mode t)

(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

(when (cedet-gnu-global-version-check t)
  (semanticdb-enable-gnu-global-databases 'c-mode)
  (semanticdb-enable-gnu-global-databases 'c++-mode))

;(when (cedet-ectag-version-check)
;  (semantic-load-enable-primary-exuberent-ctags-support))

(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key [backtab] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  ;;(local-set-key "." 'semantic-complete-self-insert)
  ;;(local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key [f12] 'semantic-complete-jump)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))

(add-hook 'c++-mode-common-hook 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-cedet-hook)

(if (file-exists-p "~/.emacs.d/ede-projects")
    (load-file "~/.emacs.d/ede-projects"))


(when (require 'ecb nil 'noerror)
  (add-to-list 'load-path "~/.emacs.d/ecb")
  (require 'ecb)
  (require 'ecb-autoloads)
  (setq ecb-auto-activate nil)
  (setq ecb-tip-of-the-day nil)
  (setq ecb-display-news-for-upgrade nil)
  (setq ecb-windows-width 0.2))


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
  (setq c-basic-offset 4)
  (setq indent-tabs-mode t)
  (setq tab-width 4)
	;;(c-set-offset 'inline-open '+)
  (c-set-offset 'substatement-open '0)
  (c-set-offset 'brace-list-open '0)
  (c-set-offset 'statement-case-open '0)
  (c-set-offset 'case-label '+)
  ;;(c-set-offset 'statement-case-intro '+)
  ;;(c-set-offset 'arglist-intro '+)
  ;; (c-set-offset 'arglist-cont '0)
  ;; (c-set-offset 'arglist-close '+)
  ;;  (c-set-offset 'innamespace '0)
  (setq show-trailing-whitespace t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  ;; (flyspell-prog-mode)
)

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(defun inside-class-enum-p (pos)
  "Checks if POS is within the braces of a C++ \"enum class\"."
  (ignore-errors
    (save-excursion
      (goto-char pos)
      (up-list -1)
      (backward-sexp 1)
      (looking-back "enum[ \t]+class[ \t]+[^}]+"))))

(defun align-enum-class (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      0
    (c-lineup-topmost-intro-cont langelem)))

(defun align-enum-class-closing-brace (langelem)
  (if (inside-class-enum-p (c-langelem-pos langelem))
      '-
    '+))

(defun fix-enum-class ()
  "Setup `c++-mode' to better handle \"class enum\"."
  (add-to-list 'c-offsets-alist '(topmost-intro-cont . align-enum-class))
  (add-to-list 'c-offsets-alist
               '(statement-cont . align-enum-class-closing-brace)))

(add-hook 'c++-mode-hook 'fix-enum-class)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hxx\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))

;; TODO AOR: clean this
(global-set-key [C-f5] 'gud-cont)
(global-set-key [C-f9] 'gud-break)
(global-set-key [C-f10] 'gud-next)
(global-set-key [C-f11] 'gud-step)

;; TODO AOR: what is this for?
(load-file "~/.emacs.d/lisp/gprof-mode.el")
(require 'gprof)
(setq auto-mode-alist (cons '("\\.gprof\\w?" . gprof-mode) auto-mode-alist))


(setq compile-command "LC_MESSAGES=C make -j5")
(setq compilation-read-command nil)

(use-package smart-compile)

(global-set-key [f6] 'smart-compile)
(global-set-key [f7] 'next-error)

;(global-set-key [f7] 'compile-goto-error-and-close-compilation-window)
;(setq compilation-window-height 15)

;; (setq compilation-finish-function
;;       (lambda (buf str)

;;         (if (string-match "exited abnormally" str)

;;             ;;there were errors
;;             (message "compilation errors, press C-x ` to visit")

;;           ;;no errors, make the compilation window go away in 0.5 seconds
;; ;          (run-at-time 0.5 nil 'delete-windows-on buf)
;;           (run-at-time 0.5 nil 'kill-buffer buf)
;;           (message "NO COMPILATION ERRORS!"))))


;; (setq compilation-finish-function
;;       (lambda (buf str)
;;         (if (string-match "*Ack-and-a-half*" (buffer-name))
;;             (if (string-match "exited abnormally" str)
;;                 (run-at-time 0.5 nil 'kill-buffer buf)
;;                  )
;;         (if (string-match "exited abnormally" str)
;;             (message "compilation errors, press C-x ` to visit")
;;           ; else
;;           ((run-at-time 0.5 nil 'kill-buffer buf)
;;           (message "NO COMPILATION ERRORS!"))
;;           ) ; (string-match "exited abnormally" str)
;;         )))

  ;; Close the compilation window if there was no error at all.
(setq compilation-exit-message-function
      (lambda (status code msg)
        ;; If M-x compile exists with a 0
        (when (and (eq status 'exit) (zerop code) (not (string-match "*Ack-and-a-half*" (buffer-name))))
          ;; then bury the *compilation* buffer, so that C-x b doesn't go there
  	  (bury-buffer "*compilation*")
  	  ;; and return to whatever were looking at before
  	  (replace-buffer-in-windows "*compilation*"))
        ;; Always return the anticipated result of compilation-exit-message-function
  	(cons msg code)))


;; (setq compilation-finish-function
;;       (lambda (buf str)

;;         (if (and (string-match "exited abnormally" str)
;;             (string-match "*Ack-and-a-half*" (buffer-name)))
;;             ((run-at-time 0.5 nil 'kill-buffer buf)
;;           (message "NO COMPILATION ERRORS!"))

;;             ;;there were errors
;;             (message "compilation errors, press C-x ` to visit")

;;           ;;no errors, make the compilation window go away in 0.5 seconds
;; ;          (run-at-time 0.5 nil 'delete-windows-on buf)
;;           )))


;; (defun bury-compile-buffer-if-successful (buffer string)
;;   "Bury a compilation buffer if succeeded without warnings "
;;   (if (and
;;        (with-current-buffer buffer
;;           (search-forward "xcolor" nil t))
;;        (not
;;         (with-current-buffer buffer
;;           (search-forward "wazaaabi" nil t))))
;;       (run-with-timer 1 nil
;;                       (lambda (buf)
;;                         (bury-buffer buf)
;;                         (switch-to-prev-buffer (get-buffer-window buf) 'kill))
;;                       buffer)))
;; (add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)


(provide 'setup-cpp)
