(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/mine")

(setq
 backup-by-copying t ; don't clobber symlinks
 backup-directory-alist '(("." . "~/.saves/"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(column-number-mode t)
(line-number-mode t)
(global-font-lock-mode t)
(setq visible-bell 'top-bottom)
(delete-selection-mode t)
(setq debug-on-error nil)

(visual-line-mode t)
(setq line-move-visual t)

(setq-default tab-width 2)

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

(require 'path-completion)

(use-package solarized-theme)

(use-package color-theme-sanityinc-solarized)

(require 'mwheel)
(mwheel-install)

(require 'paren)
(transient-mark-mode t)
(tool-bar-mode -1)
(show-paren-mode t)
(setq show-paren-delay 0)           ; how long to wait?
(setq show-paren-style 'expression) ; alternatives are 'parenthesis' and 'mixed'

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 100)

(global-auto-revert-mode t)


(set-face-background 'show-paren-match-face "#002b36")
(set-face-attribute 'show-paren-match-face nil
        :weight 'bold :underline nil :overline nil :slant 'normal)

(setq frame-title-format
      '("emacs%@" (:eval (system-name)) ": " (:eval (if (buffer-file-name)
							(abbreviate-file-name (buffer-file-name))
						      "%b")) " [%*]"))

(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

(windmove-default-keybindings 'meta)

(defun fullscreen (&optional f)
       (interactive)
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))

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


; TODO: make this work
;(defun interrupt-and-recompile ()
;  "Interrupt old compilation, if any, and recompile."
;  (interactive)
;  (ignore-errors (kill-compilation))
;  (recompile))


(global-set-key [f6] 'compile)
(global-set-key [f7] 'next-error)

(setq compilation-ask-about-save nil)
(setq compilation-read-command nil)
(setq compilation-scroll-output 'first-error)

(setq compilation-exit-message-function
      (lambda (status code msg)
        ;; If M-x compile exists with a 0
        (when (and (eq status 'exit) (zerop code) (not (string-match "*Ack-and-a-half*" (buffer-name))))
          (sleep-for 1)
          ;; then bury the *compilation* buffer, so that C-x b doesn't go there
          (bury-buffer "*compilation*")
          ;; and return to whatever were looking at before
          (delete-window (get-buffer-window (get-buffer "*compilation*"))))
        ;; Always return the anticipated result of compilation-exit-message-function
        (cons msg code)))


(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(define-key ctl-x-map "S" 'save-current-configuration)
(define-key ctl-x-map "F" 'resume)

(use-package autopair)
(autopair-global-mode) ;; enable autopair in all buffer
(put 'autopair-insert-opening 'delete-selection t)
(put 'autopair-skip-close-maybe 'delete-selection t)
(put 'autopair-insert-or-skip-quote 'delete-selection t)
(put 'autopair-extra-insert-opening 'delete-selection t)
(put 'autopair-extra-skip-close-maybe 'delete-selection t)
(put 'autopair-backspace 'delete-selection 'supersede)
(put 'autopair-newline 'delete-selection t)


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


; http://www.emacswiki.org/emacs/IncrementNumber
(defun my-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))


(defun my-decrement-number-decimal (&optional arg)
  (interactive "p*")
  (my-increment-number-decimal (if arg (- arg) -1)))

; TODO AOR: bindings does not work
(global-set-key (kbd "C-+") 'my-increment-number-decimal)
(global-set-key (kbd "C--") 'my-decrement-number-decimal)

(global-unset-key (kbd "<f10>"))

; Clean mode line

(defvar mode-line-cleaner-alist
  `((auto-complete-mode . " α")
    (yas/minor-mode . " υ")
    (egg-minor-mode . " ɣ")
    (paredit-mode . " π")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (flyspell-mode . " φ")
    (iedit-mode . " ι")
    ;; Major modes
    (lisp-interaction-mode . "λ")
    (hi-lock-mode . "")
    (python-mode . "Py")
    (ruby-mode . "Rb")
    (emacs-lisp-mode . "EL")
    (nxhtml-mode . "nx"))
  "Alist for `clean-mode-line'.

When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")


(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                 (mode-str (cdr cleaner))
                 (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
                 (setcar old-mode-str mode-str))
               ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;; TODO AOR: not sure if I should keep this use-package directive
(use-package ack)
(add-to-list 'load-path "~/.emacs.d/ack-and-a-half")
(require 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'aff 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
(defalias 'ack-with-args 'ack-and-a-half-with-args)
(global-set-key (kbd "C-S-f") 'ack)

;; Helm makes searching for anything nicer.
;; It works on top of many other commands / packages and gives them nice, flexible UI.
(use-package helm
  :config
  (progn
    (require 'helm-config)

    ;; Use C-c h instead of default C-x c, it makes more sense.
    (global-set-key (kbd "C-c x") 'helm-command-prefix)
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
    (setq helm-autoresize-max-height 0)
    (setq helm-autoresize-min-height 20)
    (helm-autoresize-mode 1)


    (global-set-key (kbd "C-x w") 'helm-for-files)

    (setq helm-boring-buffer-regexp-list
          (list
           (rx "\*")
           ;; (rx "\*code-conversion-work\*")
           ;; (rx "\*Completions\*")
           ;; (rx "\*Echo Area 0\*")
           ;; (rx "\*Echo Area 1\*")
           ;; (rx "\*Egg:Select Action\*")
           ;; (rx "\*Irony\*")
           ;; (rx "\*Messages\*")
           ;; (rx "\*Minibuf-0\*")
           ;; (rx "\*RTags Diagnostics\*")
           ;; (rx "\*RTags Raw\*")
           ;; (rx "\*scratch\*")
           ;; (rx "\*tag-info\*")
           (rx "*helm")
           )
      )


    (helm-mode 1)
    ))

;; Use Helm in Projectile.
(use-package projectile
  :config
  (progn
    (projectile-global-mode)
    ))


(use-package helm-projectile
;  :require helm projectile
  :config
  (progn
    (setq projectile-completion-system 'helm)
    (helm-projectile-on)
    ))

(use-package auto-complete)

;; TODO AOR: fix this
;; (require 'path-completion)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(ac-set-trigger-key nil)

(use-package popup)


(use-package iedit)

(defun iedit-dwim (arg)
  "Starts iedit but uses \\[narrow-to-defun] to limit its scope."
  (interactive "P")
  (if arg
      (iedit-mode)
    (save-excursion
      (save-restriction
        (widen)
        ;; this function determines the scope of `iedit-start'.
        (narrow-to-defun)
        (if iedit-mode
            (iedit-done)
          ;; `current-word' can of course be replaced by other
          ;; functions.
          (iedit-start (current-word)))))))

(global-set-key (kbd "C-;") 'iedit-mode)


(if (file-exists-p "~/.emacs.d/mine/work.el")
    (load-file "~/.emacs.d/mine/work.el"))

(provide 'setup-general)
