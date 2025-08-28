;;; helm-setup --- Helm setup  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package helm
  :config
  (progn

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

    (setq helm-buffers-fuzzy-matching t
          helm-recentf-fuzzy-match t)

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

    (setq helm-boring-buffer-regexp-list
          (list
           (rx "\*")
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

(provide 'helm-setup)
;;; helm-setup.el ends here
