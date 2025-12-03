;; TODO AOR: should I keep both egg and magit?  -*- lexical-binding: t; -*-

(delete 'Git vc-handled-backends)

(use-package magit
  :ensure t
  :bind (("C-x v a" . my/magit-blame-toggle)
         )
  )

(defun my/magit-blame-toggle ()
  "Toggle Magit blame with 'show commits adding lines' (b)."
  (interactive)
  (if (bound-and-true-p magit-blame-mode)
      ;; If blame is active, quit it
      (magit-blame-quit)
    ;; Otherwise, start blame and show commits adding lines
    (let ((current-prefix-arg nil))
      (call-interactively #'magit-blame-addition))))


(defalias 'glog 'magit-file-log)
(defalias 'gd 'magit-diff-unstaged)
(defalias 'gds 'magit-diff-staged)


(provide 'setup-vcs)
