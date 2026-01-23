;;; ui-setup --- Conf for various UI parameters -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(column-number-mode t)
(global-display-line-numbers-mode)
(line-number-mode t)
(global-font-lock-mode t)
(setq visible-bell 'top-bottom)
(delete-selection-mode t)

(visual-line-mode t)
(setq line-move-visual t)

(setq-default tab-width 2)

(setq
 scroll-margin 0
 scroll-conservatively 100000
 scroll-preserve-screen-position 1)

(setq frame-title-format
      '("emacs%@" (:eval (system-name)) ": " (:eval (if (buffer-file-name)
							(abbreviate-file-name (buffer-file-name))
						      "%b")) " [%*]"))

(use-package solarized-theme)
(use-package color-theme-sanityinc-solarized)

(set-face-attribute 'default nil :foreground "#e0e8e8")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "#82afff")
(set-face-attribute 'font-lock-function-name-face nil :foreground "#82afff")

(set-face-background 'show-paren-match "#002b36")
(set-face-attribute 'show-paren-match nil
        :weight 'bold :underline nil :overline nil :slant 'normal)

(require 'paren)
(transient-mark-mode t)
(tool-bar-mode -1)
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression) ; alternatives are 'parenthesis' and 'mixed'

;; TODO AOR: is this necessary?
(use-package popup)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-below)
  (recenter)             ;; center the current line in the first window
  (other-window 1))

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-right)
  (recenter)             ;; center the current line in the first window
  (other-window 1))

(global-set-key (kbd "C-x 2") 'split-and-follow-vertically)
(global-set-key (kbd "C-x 3") 'split-and-follow-horizontally)


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

;; TODO: there is a problem with the "loop"

;; (defun clean-mode-line ()
;;   (interactive)
;;   (loop for cleaner in mode-line-cleaner-alist
;;         do (let* ((mode (car cleaner))
;;                  (mode-str (cdr cleaner))
;;                  (old-mode-str (cdr (assq mode minor-mode-alist))))
;;              (when old-mode-str
;;                  (setcar old-mode-str mode-str))
;;                ;; major mode
;;              (when (eq mode major-mode)
;;                (setq mode-name mode-str)))))

;; (add-hook 'after-change-major-mode-hook 'clean-mode-line)

(provide 'ui-setup)
;;; ui-setup.el ends here
