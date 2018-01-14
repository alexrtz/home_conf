(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
;(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
 "Custom function to spell check next highlighted word"
 (interactive)
 (flyspell-goto-next-error)
 (ispell-word)
 )
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)
(setq ispell-dictionary "american")

(let ((langs '("american" "francais")))
	(setq lang-ring (make-ring (length langs)))
	(dolist (elem langs) (ring-insert lang-ring elem)))

(defun cycle-ispell-languages ()
	(interactive)
	(let ((lang (ring-ref lang-ring -1)))
		(ring-insert lang-ring lang)
		(ispell-change-dictionary lang)))

(global-set-key [f9] 'cycle-ispell-languages)

(provide 'setup-spelling)
