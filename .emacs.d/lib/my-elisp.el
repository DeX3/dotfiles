;;; package --- My custom config for emacs lisp
;;; Commentary:
;;; Code:
(use-package elisp-slime-nav
  :ensure t
  :general
  (:states 'normal
   :keymaps 'emacs-lisp-mode-map
   "K" 'elisp-slime-nav-describe-elisp-thing-at-point)
  :config
  (add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode) (eldoc-mode))))

(use-package evil-paredit
  :ensure t
  :general
  (:prefix my/leader
   "e e"   'my/eval-current-sexp)
  (:states 'normal
   :keymaps 'emacs-lisp-mode-map
   "] ]" 'paredit-forward-slurp-sexp
   "] [" 'paredit-forward-barf-sexp
   "[ ]" 'paredit-backward-barf-sexp
   "[ [" 'paredit-backward-slurp-sexp)
  :config
  (defun my/eval-current-sexp ()
    (interactive)
    (save-excursion
      (paredit-forward-up)
      (eval-last-sexp nil))))

(defun my/reload-help ()
  "Use revert-buffer (without confirmation) to reload the help buffer."
  (interactive)
  (message "Reloading...")
  (revert-buffer nil t))

(require 'fuco-lisp-indent)
(add-hook 'emacs-lisp-mode-hook
          (lambda () (setq-local lisp-indent-function #'Fuco1/lisp-indent-function)))


;; some bindings for help-mode
(define-key help-mode-map (kbd "DEL") 'help-go-back)
(define-key help-mode-map [tab] 'forward-button)
(define-key help-mode-map (kbd "r") 'my/reload-help)

(provide 'my-elisp)
;;; my-elisp.el ends here
