;;; shortcuts-setup --- Configure the shortcuts

;;; Commentary:

;;; Code:

(global-set-key [C-tab] 'dabbrev-expand)
(global-set-key "\C-s" 'save-buffer)
(global-set-key "\C-o" 'find-file)
(global-set-key "\C-w" 'kill-region)
(global-set-key "\C-v" 'yank)
(global-set-key "\C-f" 'isearch-forward)
(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key "\C-l" 'goto-line)
(global-set-key "\C-xk" 'kill-current-buffer)


(global-set-key (kbd "C-S-S") (lambda () (interactive) (my-desktop-save-global)))
(global-set-key (kbd "C-S-F") (lambda () (interactive) (my-desktop-read-global)))

(global-set-key (kbd "C-;") 'iedit-mode)

; TODO AOR: bindings does not work
(global-set-key (kbd "C-+") 'my-increment-number-decimal)
(global-set-key (kbd "C--") 'my-decrement-number-decimal)


;;; (global-set-key (kbd "M-/") 'company-complete-common-or-cycle)

(global-set-key (kbd "M-f") 'helm-projectile-ag)

(provide 'shortcuts-setup)
;;; shortcuts-setup.el ends here
