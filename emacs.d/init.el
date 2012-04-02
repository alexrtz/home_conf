(setq load-path (cons "/usr/share/emacs/site-lisp/" load-path))
(add-to-list 'load-path "~/.xemacs/" )

; Pour eviter une erreur qui fait chier
;(setq package-get-require-signed-base-updates nil)

(autoload 'tuareg-mode "tuareg.el" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug.el" "Run the Caml debugger" t)
(autoload 'csharp-mode "csharp-mode.el" "Major mode for editing C# code" t)

; Surbrillance des matching parentheses
(paren-set-mode 'paren)

; La roulette de la souris
(require 'mwheel)
(mwheel-install)


; Pour CLIPS
(setq auto-mode-alist (cons '("\\.clp\\w?" . lisp-mode) auto-mode-alist))
; Les autres
(setq auto-mode-alist (cons '("\\.pl\\w?" . perl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cs\\w?" . csharp-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rhtml\\w?" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))

(custom-set-faces)
(require 'font-lock)
;Les trois qui suivent c'est pour LaTeX
(set-face-foreground 'font-lock-keyword-face "blue")
(set-face-foreground 'font-lock-function-name-face "red")
(set-face-foreground 'font-lock-doc-string-face "green8")
(setq-default font-lock-use-fonts '(or (mono) (grayscale)))
(setq-default font-lock-use-colors '(color))

;Pour le Most de Syntax Highlighting
(setq-default font-lock-maximum-decoration t)
(setq-default font-lock-maximum-size 256000)
(setq-default font-lock-mode-enable-list nil)
(setq-default font-lock-mode-disable-list nil)

(remove-hook 'font-lock-mode-hook 'turn-on-fast-lock)
(remove-hook 'font-lock-mode-hook 'turn-on-lazy-shot)

;tuareg power
(custom-set-variables
 '(ps-paper-type (quote a4))
 '(delete-key-deletes-forward t)
 '(load-home-init-file t t)
 '(tuareg-in-indent 0)
 '(column-number-mode t)
 '(gnuserv-program (concat exec-directory "/gnuserv"))
 '(tuareg-let-always-indent nil)
 '(line-number-mode t)
 '(kill-whole-line t)
 '(tuareg-with-indent 0)
 ;'(c-offsets-alist (quote ((namespace . 0) (namespace . 0))))
 )

(custom-set-faces
 '(default ((t (:background "#b8cfd6" :family "courier" :size "18pt"))) t)
 '(toolbar ((t (:background "#87c0bb"))) t))

(line-number-mode 1)

(global-set-key [(alt c)] 'comment-region)
(global-set-key [(alt u)] 'uncomment-region)

; indent region
(global-set-key [(alt i)] 'indent-region)

;scrolling normal
(progn (setq scroll-step 1)
       (setq scroll-preserve-screen-position t)
       (setq scroll-conservatively 9999))

; please shut up, please shut up, please shut the fuck up
(setq visible-bell 'top-bottom)

;(require 'ruby-electric)
;	  (defun ruby-indent ()
;		(local-set-key "\C-m" 'ruby-reindent-then-newline-and-indent))
;	  (add-hook 'ruby-mode-hook 'ruby-indent)
;										; http://www.google.com/url?sa=D&q=http%3A%2F%2Fshylock.uw.hu%2FEmacs%2Fruby-electric.el
;	  (add-hook 'ruby-mode-hook 'ruby-electric-mode)
;				   
;	  (add-hook 'ruby-mode-hook
;				'(lambda()
;				   (define-key ruby-mode-map "\C-m" 'newline-and-indent)))


;; eRuby
;(require 'mmm-mode)
;(setq mmm-global-mode 'maybe)
;(setq mmm-submode-decoration-level 2)


;(mmm-add-classes
; '((eRuby-code
;    :submode ruby-mode
;    :match-face (("<%#" . mmm-comment-submode-face)
;	 ("<%=" . mmm-output-submode-face)
; ("<%"	. mmm-code-submode-face))
;    :front "<%[#=]?"
;    :back  "%>"
;    :insert ((?% eRuby-code	  nil @ "<%"  @ " " _ " " @ "%>" @)
;	     (?# eRuby-comment	  nil @ "<%#" @ " " _ " " @ "%>" @)
;	     (?= eRuby-expression nil @ "<%=" @ " " _ " " @ "%>" @))
;    )))
; need to figure out how this can co-exist with mason
;; 	  (add-hook 'html-mode-hook
;; 				(lambda ()
;; 				  (setq mmm-classes '(eRuby-code))
;; 				  (mmm-mode-on)))
;; 	  (setq auto-mode-alist
;; 			(nconc '(("\\.rhtml$" . html-mode)) auto-mode-alist))

;(mmm-add-classes
; '((ruby-heredoc
;    :front "<<-\\([a-zA-Z0-9_-]+\\)"
;    :front-offset (end-of-line 1)
;    :back "~1$"
;    :save-matches 1
;    :submode text-mode
;    :insert ((?d ruby-heredoc "Here-document Name: " @ "<<" str _ "\n"
;		 @ "\n" @ str "\n" @))
;    )))
;(add-hook 'ruby-mode-hook 
;	  (lambda ()
;	    (setq mmm-classes '(ruby-heredoc))
;	    (mmm-mode-on)))
;(add-hook 'ruby-mode-hook 'turn-on-font-lock)
;))
