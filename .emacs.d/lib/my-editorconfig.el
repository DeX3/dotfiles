(use-package editorconfig
  :after js2-mode
  :ensure t
  :config
  (editorconfig-mode 1)
  (add-hook
   'editorconfig-custom-hooks
   (lambda (hash)
     (let ((indent-size (gethash 'indent_size hash)))
       (when (not (null indent-size))
         (setq js-indent-level (string-to-number indent-size))
         (setq js-expr-indent-offset (- js-indent-level))))))
  (add-to-list 'editorconfig-indentation-alist
               '(js2-mode js2-basic-offset))
  :init
  (add-hook 'js2-mode-hook (progn
                             (editorconfig-mode 1)
                             (when (boundp 'js2-basic-offset)
                               (setq evil-shift-width js2-basic-offset
                                     js-indent-level js2-basic-offset))
                             (when (boundp 'js-indent-level)
                               (setq js-expr-indent-offset (- js-indent-level)))))
  )

(use-package column-marker
  :ensure t
  :config)

(provide 'my-editorconfig)
