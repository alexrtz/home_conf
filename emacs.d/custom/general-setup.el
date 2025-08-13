;;; general-setup --- General configuration  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(setq
 backup-by-copying t ; don't clobber symlinks
 backup-directory-alist '(("." . "~/.saves/"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)

(setq debug-on-error nil)

(setq large-file-warning-threshold 100000000)

(run-with-timer 60 1000000 'save-current-configuration)

(use-package company
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (setq company-idle-delay 0)))

;(completion-preview-mode t)

(use-package flycheck
  :config
  (progn
    (global-flycheck-mode)))

(use-package flycheck-inline)

(with-eval-after-load 'flycheck
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))

;(require 'path-completion)

(electric-pair-mode)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1)
  )

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 100)

(global-auto-revert-mode t)

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


(setq mouse-yank-at-point t)

;(global-set-key [f6] 'compile)
;(global-set-key [f7] 'next-error)

(defun touch-trigger ()
  "Run a shell command."
  (interactive)
  (save-some-buffers t)
  (shell-command "touch /tmp/trigger"))

;; Define a keybinding to trigger the function
(global-set-key (kbd "<f7>") 'touch-trigger)

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

(if (projectile-project-root)
    (progn
      (setq desktop-dirname (projectile-project-root))
      (desktop-save-mode 1)
      )
  )

(defun my-desktop-read-global ()
  "Load the global desktop save (useful when emacs has not been started from inside a versioned directory)"
  (desktop-read "~/.config/mine/")
  )


(defun my-desktop-save-global ()
  "Save the current desktop at the global level (useful when emacs has not been started from inside a versioned directory)"
  (desktop-save "~/.config/mine/")
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

(global-unset-key (kbd "<f10>"))

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

(if (file-exists-p "~/.emacs.d/mine/work.el")
    (load-file "~/.emacs.d/mine/work.el"))

(provide 'general-setup)
;;; general-setup.el ends here
