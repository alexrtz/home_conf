;; CMake

(use-package cmake-mode)
(setq auto-mode-alist (cons '("\\CMakeLists.txt\\w?" . cmake-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cmake\\w?" . cmake-mode) auto-mode-alist))

(defun my-cmake-mode-hook()
  (setq tab-width 2)
  (setq c-basic-offset 2)
  (setq indent-tabs-mode nil)
  (setq show-trailing-whitespace t)
;  (add-hook 'before-save-hook 'delete-trailing-whitespace)
)

;; Docker
(use-package dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(add-hook 'cmake-mode-hook 'my-cmake-mode-hook)

;; QMake

;; Rake
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("^Rakefile$" . ruby-mode))

(provide 'setup-various-build-systems)
