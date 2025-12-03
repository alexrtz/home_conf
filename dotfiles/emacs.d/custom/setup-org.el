;; -*- lexical-binding: t; -*-

(use-package org-journal
  :ensure t
  :defer t
  :config
  (setq
   org-journal-date-format "%A, %d %B %Y"
   org-journal-dir "~/Documents/journal/"
   org-journal-file-type 'monthly)
  :bind* ("C-c C-j" . org-journal-new-entry)
  )


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
  ;(global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
  (global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
  (global-set-key (kbd "<f10> a") 'bh/show-org-agenda)
  (global-set-key (kbd "<f10> b") 'bbdb)
  (global-set-key (kbd "<f10> c") 'calendar)
  (global-set-key (kbd "<f10> f") 'boxquote-insert-file)
  (global-set-key (kbd "<f10> g") 'gnus)
  (global-set-key (kbd "<f10> h") 'bh/hide-other)
  (global-set-key (kbd "<f10> n") 'org-narrow-to-subtree)
  (global-set-key (kbd "<f10> w") 'widen)
  (global-set-key (kbd "<f10> u") 'bh/narrow-up-one-level)

  (global-set-key (kbd "<f10> I") 'bh/punch-in)
  (global-set-key (kbd "<f10> O") 'bh/punch-out)

  (global-set-key (kbd "<f10> o") 'bh/make-org-scratch)

  (global-set-key (kbd "<f10> r") 'boxquote-region)
  (global-set-key (kbd "<f10> s") 'bh/switch-to-scratch)

  (global-set-key (kbd "<f10> t") 'bh/insert-inactive-timestamp)
  (global-set-key (kbd "<f10> T") 'tabify)
  (global-set-key (kbd "<f10> U") 'untabify)

  (global-set-key (kbd "<f10> v") 'visible-mode)
  (global-set-key (kbd "<f10> SPC") 'bh/clock-in-last-task)
  (global-set-key (kbd "C-<f10>") 'previous-buffer)
  (global-set-key (kbd "M-<f10>") 'org-toggle-inline-images)
  (global-set-key (kbd "C-x n r") 'narrow-to-region)
  (global-set-key (kbd "C-<f10>") 'next-buffer)
  (global-set-key (kbd "<f11>") 'org-clock-goto)
  (global-set-key (kbd "C-<f11>") 'org-clock-in)
  (global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
  (global-set-key (kbd "C-M-r") 'org-capture)
  (global-set-key (kbd "C-c r") 'org-capture)

  (setq org-todo-keywords
	(quote ((sequence "TODO(t)" "DOING(p)" "|" "DONE(d!/!)")
		(sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE"))))

  (setq org-todo-keyword-faces
	(quote (("TODO" :foreground "red" :weight bold)
		("DOING" :foreground "pink" :weight bold)
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
    (outline-hide-other)
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
             (org-defkey org-mode-map "\C-c;"    'undefined)
             (add-hook 'org-metaup-hook 'windmove-up)
             (add-hook 'org-metaleft-hook 'windmove-left)
             (add-hook 'org-metadown-hook 'windmove-down)
             (add-hook 'org-metaright-hook 'windmove-right)
             )
          'append)

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-o") 'bh/mail-subtree))
          'append)

(defun my/org-hide-done ()
  "Fold all headlines marked as DONE."
  (org-map-entries
   (lambda ()
     (org-cycle-hide-drawers 'all))
   "/DONE" 'file)
  )


(add-hook 'org-mode-hook #'my/org-hide-done)

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Documents/org-files/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/Documents/org-files/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/Documents/org-files/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ;("j" "Journal" entry (file+datetree "~/Documents/org-files/diary.org")
              ; "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/Documents/org-files/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/Documents/org-files/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/Documents/org-files/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/Documents/org-files/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))



(defun bh/mail-subtree ()
  (interactive)
  (org-mark-subtree)
  (org-mime-subtree))

;; Enable abbrev-mode
(add-hook 'org-mode-hook (lambda () (abbrev-mode 1)))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/Documents/org-roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(setq-default org-roam-dailies-directory "daily")

(setq-default org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))

(setq org-roam-v2-ack t)

(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-j") #'helm-for-files))

(provide 'setup-org)
