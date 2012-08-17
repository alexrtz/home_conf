(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/anything-config")
(add-to-list 'load-path "~/.emacs.d/highlight-indentation")

; C/C++ stuff
; Currently CEDET issues a warning “Warning: cedet-called-interactively-p called with 0 arguments,
; but requires 1”, which can be suppressed by adding (setq byte-compile-warnings nil) in your
; .emacs file before CEDET is loaded
;(setq byte-compile-warnings nil)
(load-file "~/.emacs.d/cedet/common/cedet.el")
(global-ede-mode t)
(semantic-load-enable-excessive-code-helpers)
(require 'semantic-ia)
(require 'semantic-gcc)
;(semantic-add-system-include "/home/alexandre/Documents/Programmes/cmake/Source" 'c++-mode)
;(semantic-add-system-include "/home/alexandre/Documents/Programmes/cmake/Source/CTest" 'c++-mode)
(semantic-add-system-include "/usr/include/c++/4.5.2/" 'c++-mode)
;(semantic-add-system-include "/usr/include/boost" 'c++-mode)
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
	(local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
)
(add-hook 'c++-mode-common-hook 'my-cedet-hook)
(add-hook 'c-mode-common-hook 'my-cedet-hook)

(if (file-exists-p "~/.emacs.d/ede-projects")
    (load-file "~/.emacs.d/ede-projects"))


(cogre-uml-enable-unicode)


(add-to-list 'load-path "~/.emacs.d/ecb")
(require 'ecb)
;(require 'ecb-autoloads)
(setq ecb-auto-activate nil)
(setq ecb-tip-of-the-day nil)
(setq ecb-display-news-for-upgrade nil)
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
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
)


(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hxx\\'" . c++-mode))


(defun my-nany-mode-hook()
  (setq indent-tabs-mode t)
  (setq tab-width 2)
)

(add-hook 'nany-mode-hook 'my-nany-mode-hook)

(require 'highlight-indentation)

(defun my-python-mode-hook()
  (set-face-background 'highlight-indentation-face "#23664f")
  (set-face-background 'highlight-indentation-current-column-face "#24a076")
  (highlight-indentation-mode)
  )

(add-hook 'python-mode-hook 'my-python-mode-hook)

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

(defun trailing-whitespaces-hook ()
  (setq show-trailing-whitespace t)
  )

(add-hook 'markdown-mode-hook 'trailing-whitespaces-hook)

(defun my-nany-hook ()
  (setq show-trailing-whitespace t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  )
(add-hook 'nany-mode-hook 'my-nany-hook)

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

;(autoload 'ack-same "full-ack" nil t)
;(autoload 'ack "full-ack" nil t)
;(autoload 'ack-find-same-file "full-ack" nil t)
;(autoload 'ack-find-file "full-ack" nil t)


(require 'org-install)
(defun my-org-mode-hook()
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb)
  (setq org-log-done t)
  (setq org-agenda-include-diary t)

  ;; (add-hook 'message-mode-hook 'orgstruct++-mode 'append)
  ;; (add-hook 'message-mode-hook 'turn-on-auto-fill 'append)
  ;; (add-hook 'message-mode-hook 'bbdb-define-all-aliases 'append)
  ;; (add-hook 'message-mode-hook 'orgtbl-mode 'append)
  ;; (add-hook 'message-mode-hook 'turn-on-flyspell 'append)
  ;; (add-hook 'message-mode-hook
  ;;           '(lambda () (setq fill-column 72))
  ;;           'append)
  ;; (add-hook 'message-mode-hook
  ;;           '(lambda () (local-set-key (kbd "C-c M-o") 'org-mime-htmlize))
  ;;           'append)

  ;; Custom Key Bindings
  (global-set-key (kbd "<f12>") 'org-agenda)
  (global-set-key (kbd "<f5>") 'bh/org-todo)
  (global-set-key (kbd "<S-f5>") 'bh/widen)
  (global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
  (global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
  (global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
  (global-set-key (kbd "<f9> b") 'bbdb)
  (global-set-key (kbd "<f9> c") 'calendar)
  (global-set-key (kbd "<f9> f") 'boxquote-insert-file)
  (global-set-key (kbd "<f9> g") 'gnus)
  (global-set-key (kbd "<f9> h") 'bh/hide-other)
  (global-set-key (kbd "<f9> n") 'org-narrow-to-subtree)
  (global-set-key (kbd "<f9> w") 'widen)
  (global-set-key (kbd "<f9> u") 'bh/narrow-up-one-level)

  (global-set-key (kbd "<f9> I") 'bh/punch-in)
  (global-set-key (kbd "<f9> O") 'bh/punch-out)

  (global-set-key (kbd "<f9> o") 'bh/make-org-scratch)

  (global-set-key (kbd "<f9> r") 'boxquote-region)
  (global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

  (global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
  (global-set-key (kbd "<f9> T") 'tabify)
  (global-set-key (kbd "<f9> U") 'untabify)

  (global-set-key (kbd "<f9> v") 'visible-mode)
  (global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
  (global-set-key (kbd "C-<f9>") 'previous-buffer)
  (global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
  (global-set-key (kbd "C-x n r") 'narrow-to-region)
  (global-set-key (kbd "C-<f10>") 'next-buffer)
  (global-set-key (kbd "<f11>") 'org-clock-goto)
  (global-set-key (kbd "C-<f11>") 'org-clock-in)
  (global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
  (global-set-key (kbd "C-M-r") 'org-capture)
  (global-set-key (kbd "C-c r") 'org-capture)

  (setq org-todo-keywords
	(quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
		(sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE"))))

  (setq org-todo-keyword-faces
	(quote (("TODO" :foreground "red" :weight bold)
		("NEXT" :foreground "pink" :weight bold)
		("DONE" :foreground "forest green" :weight bold)
		("WAITING" :foreground "orange" :weight bold)
		("HOLD" :foreground "magenta" :weight bold)
		("CANCELLED" :foreground "forest green" :weight bold)
		("PHONE" :foreground "forest green" :weight bold))))

  (setq org-todo-state-tags-triggers
	(quote (("CANCELLED" ("CANCELLED" . t))
		("WAITING" ("WAITING" . t))
		("HOLD" ("WAITING" . t) ("HOLD" . t))
		(done ("WAITING") ("HOLD"))
		("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
		("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
		("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
  )

(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

(defun bh/set-truncate-lines ()
  "Toggle value of truncate-lines and refresh window display."
  (interactive)
  (setq truncate-lines (not truncate-lines))
  ;; now refresh window display (an idiom from simple.el):
  (save-excursion
    (set-window-start (selected-window)
                      (window-start (selected-window)))))

(defun bh/make-org-scratch ()
  (interactive)
  (find-file "/tmp/publish/scratch.org")
  (gnus-make-directory "/tmp/publish"))

(defun bh/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))


(if (file-exists-p "~/.emacs.d/agenda-files")
    (load-file "~/.emacs.d/agenda-files"))

;; flyspell mode for spell checking everywhere
;(add-hook 'org-mode-hook 'turn-on-flyspell 'append)

(add-hook 'org-mode-hook 'my-org-mode-hook)

;; Disable C-c [ and C-c ] and C-c ; in org-mode
(add-hook 'org-mode-hook
          '(lambda ()
             ;; Undefine C-c [ and C-c ] since this breaks my
             ;; org-agenda files when directories are include It
             ;; expands the files in the directories individually
             (org-defkey org-mode-map "\C-c["    'undefined)
             (org-defkey org-mode-map "\C-c]"    'undefined)
             (org-defkey org-mode-map "\C-c;"    'undefined))
          'append)

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-o") 'bh/mail-subtree))
          'append)


(defun bh/mail-subtree ()
  (interactive)
  (org-mark-subtree)
  (org-mime-subtree))

;; Enable abbrev-mode
(add-hook 'org-mode-hook (lambda () (abbrev-mode 1)))




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

(setq tab-width 2)

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


(setq
	scroll-margin 0
	scroll-conservatively 100000
	scroll-preserve-screen-position 1)


(global-set-key [C-tab] 'dabbrev-expand)
(global-set-key "\C-s" 'save-buffer)
(global-set-key "\C-o" 'find-file)
(global-set-key "\C-w" 'kill-region)
(global-set-key "\C-v" 'yank)
(global-set-key "\C-f" 'isearch-forward)
(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key "\C-l" 'goto-line)
(global-set-key "\C-xk" 'kill-this-buffer)
(global-set-key "\C-b" 'iswitchb-buffer)



(global-set-key [C-f5] 'gud-cont)
(global-set-key [C-f9] 'gud-break)
(global-set-key [C-f10] 'gud-next)
(global-set-key [C-f11] 'gud-step)

(iswitchb-mode t)
(add-to-list 'iswitchb-buffer-ignore "*Scratch*")
(add-to-list 'iswitchb-buffer-ignore "*Messages*")
(add-to-list 'iswitchb-buffer-ignore "*Completions")
(add-to-list 'iswitchb-buffer-ignore "*CEDET Global")
(add-to-list 'iswitchb-buffer-ignore "*Egg:Select Action*")
(add-to-list 'iswitchb-buffer-ignore "*anything")
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

(defun my-cmake-mode-hook()
  ;;  (setq c-basic-offset 2)
  (setq indent-tabs-mode t)
  (setq tab-width 2)
  ;;	(c-set-offset 'inline-open '+)
  ;;(c-set-offset 'substatement-open '0)
  ;;(c-set-offset 'brace-list-open '0)
  ;;(c-set-offset 'statement-case-open '0)
  ;;(c-set-offset 'case-label '+)
  ;;	(c-set-offset 'statement-case-intro '+)
  ;;(c-set-offset 'arglist-intro '++)
  ;;(c-set-offset 'arglist-cont '0)
  ;;(c-set-offset 'arglist-close '+)
  ;;  (c-set-offset 'innamespace '0)
  (setq show-trailing-whitespace t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
)


(add-hook 'cmake-mode-hook 'my-cmake-mode-hook)

(setq compile-command "LC_MESSAGES=C make")
(setq compilation-read-command nil)

(require 'smart-compile)

(global-set-key [f6] 'smart-compile)
(global-set-key [f7] 'next-error)

;(global-set-key [f6] 'smart-compile)
;(global-set-key [f7] 'compile-goto-error-and-close-compilation-window)
;(setq compilation-window-height 15)

(setq compilation-finish-function
      (lambda (buf str)

        (if (string-match "exited abnormally" str)

            ;;there were errors
            (message "compilation errors, press C-x ` to visit")

          ;;no errors, make the compilation window go away in 0.5 seconds
          (run-at-time 0.5 nil 'delete-windows-on buf)
          (message "NO COMPILATION ERRORS!"))))


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



(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


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


(add-to-list 'load-path
              "~/.emacs.d/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")


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
