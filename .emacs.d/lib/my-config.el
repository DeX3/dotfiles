(setq
 inhibit-startup-screen t
 x-select-enable-clipboard t)

; tabs are evil
(setq-default
 indent-tabs-mode nil
 tab-width 2
 tab-stop-list (number-sequence 2 120 2)
 indent-tabs-mode nil)

(tool-bar-mode -1)     ; disable the tool-bar
(menu-bar-mode -1)     ; disable the menu-bar
(show-paren-mode)
(electric-pair-mode 1)
(winner-mode 1)
(add-hook 'prog-mode-hook #'linum-mode)

(set-face-attribute 'default nil :height 115)

(defalias 'yes-or-no-p 'y-or-n-p) ; use y or n everywhere cause it's shorter to type

(set-default 'truncate-lines t)
(-each '(message-mode-hook)
 (lambda (hook) (add-hook hook (lambda () (message "turning truncate off!")(setq truncate-lines nil)))))

; always wrap around in messages buffer
(with-current-buffer (messages-buffer)
  (setq-local truncate-lines nil))

(provide 'my-config)
