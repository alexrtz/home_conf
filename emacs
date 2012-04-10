(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/anything-config")

; C/C++ stuff

(load-file "~/.emacs.d/cedet/common/cedet.el")
(global-ede-mode t)
(semantic-load-enable-excessive-code-helpers)
(require 'semantic-ia)
(require 'semantic-gcc)
;(semantic-add-system-include "/home/alexandre/Documents/Programmes/cmake/Source" 'c++-mode)
;(semantic-add-system-include "/home/alexandre/Documents/Programmes/cmake/Source/CTest" 'c++-mode)
(semantic-add-system-include "/usr/include/c++/4.5.2/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/boost" 'c++-mode)
(require 'semanticdb)
(global-semanticdb-minor-mode 1)
(require 'semanticdb-global)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)
(semantic-load-enable-primary-exuberent-ctags-support)

(defun my-cedet-hook ()
	(local-set-key [(control return)] 'semantic-ia-complete-symbol)
	(local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
	(local-set-key "\C-c>" 'semantic-complete-analyze-inline)
	(local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
;	(local-set-key "." 'semantic-complete-self-insert)
;	(local-set-key ">" 'semantic-complete-self-insert)
	(local-set-key [f12] 'semantic-complete-jump)
	(local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle))
(add-hook 'c++-mode-common-hook 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-cedet-hook)

(if (file-exists-p "~/.ede-projects")
    (load-file "~/.ede-projects"))


(cogre-uml-enable-unicode)

(add-to-list 'load-path "~/.emacs.d/ecb")
(require 'ecb)
(require 'ecb-autoloads)
(setq ecb-auto-activate nil)
(setq ecb-tip-of-the-day nil)
(setq ecb-windows-width 0.2)

; Enabling this hook makes emacs less responsive and it can be annoying on a "little" machine
;(defun my-c-mode-cedet-hook ()
; (local-set-key "." 'semantic-complete-self-insert)
; (local-set-key ">" 'semantic-complete-self-insert))
;(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)
;(add-hook 'c++-mode-common-hook 'my-c-mode-cedet-hook)


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
	 ;  (setq c-basic-offset 2)
	(setq indent-tabs-mode t)
	(setq tab-width 2)
;	(c-set-offset 'inline-open '+)
	(c-set-offset 'substatement-open '0)
	(c-set-offset 'brace-list-open '0)
	(c-set-offset 'statement-case-open '0)
	(c-set-offset 'case-label '+)
;	(c-set-offset 'statement-case-intro '+)
	(c-set-offset 'arglist-intro '++)
	(c-set-offset 'arglist-cont '0)
	(c-set-offset 'arglist-close '+)
;  (c-set-offset 'innamespace '0)
	(setq show-trailing-whitespace t)
	)


(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hxx\\'" . c++-mode))


(defun fullscreen (&optional f)
       (interactive)
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

;(fullscreen)


; anything

(require 'anything-config)

(global-set-key (kbd "C-x w")
  (lambda() (interactive)
    (anything
     :prompt "Switch to: "
     :candidate-number-limit 10                 ;; up to 10 of each 
     :sources
     '( anything-c-source-buffers               ;; buffers 
        anything-c-source-recentf               ;; recent files 
        anything-c-source-bookmarks             ;; bookmarks
        anything-c-source-files-in-current-dir+ ;; current dir
        anything-c-source-locate))))            ;; use 'locate'


;; (add-hook 'emacs-lisp-mode-hook
;;   (lambda()
;;   ;; other stuff...
;;   ;; ...
;;   ;; put useful info under C-c i
;;     (local-set-key (kbd "C-c i")
;;       (lambda() (interactive)
;;         (anything
;;           :prompt "Info about: "
;;           :candidate-number-limit 5
;;           :sources
;;           '( anything-c-source-emacs-functions
;;              anything-c-source-emacs-variables
;;              anything-c-source-info-elisp
;;              anything-c-source-emacs-commands
;;              anything-c-source-emacs-source-defun
;;              anything-c-source-emacs-lisp-expectations
;;              anything-c-source-emacs-lisp-toplevels
;;              anything-c-source-emacs-functions-with-abbrevs
;;              anything-c-source-info-emacs))))

; /anything

(require 'color-theme-solarized)
(setq color-theme-is-global t)
(load-file "~/.emacs.d/color-theme-solarized.el")
(color-theme-solarized-dark)

(load-file "~/.emacs.d/nany-mode.el")
(add-to-list 'auto-mode-alist '("\\.ny\\'" . nany-mode))

(load-file "~/.emacs.d/markdown-mode.el")
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(defun my-markdown-hook ()
  (setq show-trailing-whitespace t)
  )
(add-hook 'markdown-mode-hook 'my-markdown-hook)

;(load-file "~/.emacs.d/plantuml-mode.el")
;(require 'plantuml-mode)

; http://scottmcpeak.com/elisp/scott.emacs.el
; ------------------- yes-or-no-p ---------------------
; There are a number of situations where Emacs wants to ask me a question,
; but the answer is always the same (or, it's easy to get the effect of
; the other answer afterwards).  The main example is the question:
;
;   File foo.txt has changed on disk.  Reread from disk?
;
; This question is annoying because it gets asked while I'm moving around
; in a debugger stack trace, and often don't care about the file I happen
; to be at (because I want to move past that frame anyway).  Moreover,
; my F12 binding lets me re-read files with a single keystroke, so if I
; actually *do* want to re-read it's easy to do.

; First, I need the original definition of yes-or-no-p so I can call it
; after I've replaced its definition.  In case .emacs gets re-read
; after startup, avoid losing the original definition.
(if (fboundp 'orig-yes-or-no-p)
	nil        ; it's already bound, don't re-bind
	(fset 'orig-yes-or-no-p (symbol-function 'yes-or-no-p))
)

; Now, define my version in terms of `orig-yes-or-no-p'.
(defun yes-or-no-p (prompt)
	"Ask user a yes-or-no question.  Return t if answer is yes, nil if no.
This is a wrapper around `orig-yes-or-no'."
	(if (string-match
			 ; This message is created in lisp/files.el, and there are four
			 ; variations.  I'm intentionally matching two of them.
			 "File .* changed on disk.  Reread from disk"
			 prompt)

		; it's that question; the answer is no, but I *do* want to know
		; that it has changed
		(progn (message "Note: File has changed on disk.") nil)

		; it's a different question; for now, just ask me; I'll probably
		; add more patterns to the above as I think of other questions that
		; I don't want asked
		(orig-yes-or-no-p prompt)
	)
)

(require 'mwheel)
(mwheel-install)


(require 'paren)


(transient-mark-mode t)
(tool-bar-mode nil)
(show-paren-mode)

(setq frame-title-format
      '("emacs%@" (:eval (system-name)) ": " (:eval (if (buffer-file-name)
							(abbreviate-file-name (buffer-file-name))
						      "%b")) " [%*]"))


;; (setq mode-line-format
;;   (list
;;     ;; the buffer name; the file name as a tool tip
;;     '(:eval (propertize "%b " 'face 'font-lock-keyword-face
;;         'help-echo (buffer-file-name)))

;;     ;; line and column
;;     "(" ;; '%02' to set to 2 chars at least; prevents flickering
;;       (propertize "%02l" 'face 'font-lock-type-face) ","
;;       (propertize "%02c" 'face 'font-lock-type-face) 
;;     ") "

;;     ;; relative position, size of file
;;     "["
;;     (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
;;     "/"
;;     (propertize "%I" 'face 'font-lock-constant-face) ;; size
;;     "] "

;;     ;; the current major mode for the buffer.
;;     "["

;;     '(:eval (propertize "%m" 'face 'font-lock-string-face
;;               'help-echo buffer-file-coding-system))
;;     "] "


;;     "[" ;; insert vs overwrite mode, input-method in a tooltip
;;     '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
;;               'face 'font-lock-preprocessor-face
;;               'help-echo (concat "Buffer is in "
;;                            (if overwrite-mode "overwrite" "insert") " mode")))

;;     ;; was this buffer modified since the last save?
;;     '(:eval (when (buffer-modified-p)
;;               (concat ","  (propertize "Mod"
;;                              'face 'font-lock-warning-face
;;                              'help-echo "Buffer has been modified"))))

;;     ;; is this buffer read-only?
;;     '(:eval (when buffer-read-only
;;               (concat ","  (propertize "RO"
;;                              'face 'font-lock-type-face
;;                              'help-echo "Buffer is read-only"))))  
;;     "] "

;;     ;; add the time, with the date and the emacs uptime in the tooltip
;;     '(:eval (propertize (format-time-string "%H:%M")
;;               'help-echo
;;               (concat (format-time-string "%c; ")
;;                       (emacs-uptime "Uptime:%hh"))))
;;     " --"
;;     ;; i don't want to see minor-modes; but if you want, uncomment this:
;;     ;; minor-mode-alist  ;; list of minor modes
;;     "%-" ;; fill with '-'
;;     ))


;; (setq mode-line-format
;; (list
;; my-mode-line-buffer-name
;; my-mode-line-position
;; my-mode-line-relative-position
;; my-mode-line-major-mode
;; "["
;; my-mode-line-insert-indicator
;; my-mode-line-modified-indicator
;; "] "
;; my-mode-line-read-only-indicator
;; my-mode-line-time
;; " --"
;; ;; i don't want to see minor-modes; but if you want, uncomment this:
;; ;; minor-mode-alist ;; list of minor modes
;; my-mode-line-padding ))

;; With individual parts defined like so

;; (setq my-mode-line-position
;; ;; line and column
;; (list
;; "(" ;; '%02' to set to 2 chars at least; prevents flickering
;; (propertize "%02l" 'face 'font-lock-type-face) ","
;; (propertize "%02c" 'face 'font-lock-type-face)
;; ") " ))

(windmove-default-keybindings 'meta)

;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-up (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-down (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-left (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice windmove-right (before other-window-now activate)
  (when buffer-file-name (save-buffer)))

(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(define-key ctl-x-map "S" 'save-current-configuration)
(define-key ctl-x-map "F" 'resume)

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)


(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-include-diary t)

(require 'revbufs)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 100)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(global-auto-revert-mode t)

; Disables vc-git
(delete 'Git vc-handled-backends)

(load-file "~/.emacs.d/egg/egg.el")
(require 'egg)

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(column-number-mode t)
(line-number-mode t)
(global-font-lock-mode t)
(setq visible-bell 'top-bottom)
(delete-selection-mode t)

(visual-line-mode t)
(setq line-move-visual t)

; Don't know why this does not work...
;(setq show-trailing-whitespace t)

;(setq tab-always-indent 'complete)

(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffer
(put 'autopair-insert-opening 'delete-selection t)
(put 'autopair-skip-close-maybe 'delete-selection t)
(put 'autopair-insert-or-skip-quote 'delete-selection t)
(put 'autopair-extra-insert-opening 'delete-selection t)
(put 'autopair-extra-skip-close-maybe 'delete-selection t)
(put 'autopair-backspace 'delete-selection 'supersede)
(put 'autopair-newline 'delete-selection t)

; TODO AOR: find why this does not work
(require 'rainbow-delimiters) 
(add-hook 'c++-mode-common-hook 'rainbow-delimiters-mode)

(setq
	scroll-margin 0
	scroll-conservatively 100000
	scroll-preserve-screen-position 1)




(global-set-key [C-tab] 'dabbrev-expand)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-w") 'kill-region)
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key "\C-x\C-b" 'buffer-menu)

(global-set-key [C-f5] 'gud-cont)
(global-set-key [C-f9] 'gud-break)
(global-set-key [C-f10] 'gud-next)
(global-set-key [C-f11] 'gud-step)

(iswitchb-mode t)
(add-to-list 'iswitchb-buffer-ignore "*Scratch*")
(add-to-list 'iswitchb-buffer-ignore "*Messages*")
(add-to-list 'iswitchb-buffer-ignore "*Completions")
(add-to-list 'iswitchb-buffer-ignore "*ftp ")
(add-to-list 'iswitchb-buffer-ignore "^[tT][aA][gG][sS]$")

; We want thos file in UTF-8 by default
(modify-coding-system-alist 'file "\\.php$" 'utf-8)
(modify-coding-system-alist 'file "\\.plant$" 'utf-8)
(modify-coding-system-alist 'file "\\.py$" 'utf-8)
(modify-coding-system-alist 'file "\\.csv$" 'utf-8)
(modify-coding-system-alist 'file "\\.tex$" 'utf-8)
(modify-coding-system-alist 'file "\\.rb$" 'utf-8)
(modify-coding-system-alist 'file "\\.yaml$" 'utf-8)
(modify-coding-system-alist 'file "\\.yml$" 'utf-8)
(modify-coding-system-alist 'file "\\.sql$" 'utf-8)

(load-file "~/.emacs.d/gprof-mode.el")
(require 'gprof)
(setq auto-mode-alist (cons '("\\.gprof\\w?" . gprof-mode) auto-mode-alist))

(require 'cmake-mode)
(setq auto-mode-alist (cons '("\\CMakeLists.txt\\w?" . cmake-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cmake\\w?" . cmake-mode) auto-mode-alist))

(setq compile-command "LC_MESSAGES=C make")
(setq compilation-read-command nil)

(require 'smart-compile)

(global-set-key [f6] 'smart-compile)
(global-set-key [f7] 'next-error)

;(global-set-key [f6] 'smart-compile)
;(global-set-key [f7] 'compile-goto-error-and-close-compilation-window)
;(setq compilation-window-height 15)





; PERL stuff

;(setq cperl-basic-offset 2)
;(setq cperl-indent-level 2)

;(defun my-cperl-mode-hook()
;  (setq cperl-indent-level 2
;	cperl-basic-offset 2
;	cperl-close-paren-offset -2
;	cperl-continued-statement-offset 2
;	cperl-indent-parens-as-block t
;	cperl-tab-always-indent t)
;)

(add-hook 'cperl-mode-hook 'my-cperl-mode-hook)

; ---- language-env DON'T MODIFY THIS LINE!
;(if (>= emacs-major-version 21)
;    (progn
;      (set-language-environment "UTF-8")
;      (setq selection-coding-system 'compound-text-with-extensions)
;    )
;    (if (>= emacs-major-version 20)
;        (set-language-environment "UTF-8")
;        (require 'iso-syntax)))
;; Names for calendar command.
;; These should be derived from nl_langinfo() by emacs
;;
(defvar calendar-day-name-array
	["dim" "lun" "mar" "mer" "jeu" "ven" "sam"])
(defvar calendar-month-name-array
	["janvier" "février" "mars" "avril" "mai" "juin"
	 "juillet" "août" "septembre" "octobre" "novembre" "décembre"])


; ---- language-env end DON'T MODIFY THIS LINE!
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(dta-default-cfg "default.conf")
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-tree-indent 1)
 '(ecb-windows-width 0.2)
 '(inhibit-startup-screen t)
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#002b36" :foreground "#839496" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
