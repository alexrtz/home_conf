;; TODO AOR: should I keep both egg and magit?  -*- lexical-binding: t; -*-

(delete 'Git vc-handled-backends)
(use-package egg)

(defalias 'glog 'magit-file-log)
(defalias 'gd 'magit-diff-unstaged)
(defalias 'gds 'magit-diff-staged)


(provide 'setup-vcs)
