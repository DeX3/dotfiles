(defconst dotfile "~/.emacs.d/init.el")

(defun my-funcs/reload-dotfile ()
  "Reload '~/.emacs.d/init.el'."
  (interactive)
  (load-file dotfile))

(defun my-funcs/open-dotfile ()
  "Open '~/.emacs.d/init.el'."
  (interactive)
  (find-file dotfile))

(defconst my-funcs/pairs '(("(" . ")") ("[" . "]") ("{" . "}")))

(defun my-funcs/get-pair ()
  "Get the according pair around the point or return nil if point is not inside an adjacent pair."
  (let ((preceding (string (preceding-char)))
	(following (string (following-char))))
    (let ((match (cdr (assoc preceding my-funcs/pairs))))
	(if (equal following match)
	    match
	  nil))))

(defun my-funcs/smart-space ()
  "Insert a space at point, and if inside and adjacent pair,
also insert another space to keep whitespace balanced."
  (interactive)
  (when (my-funcs/get-pair)
    (insert " ")
    (backward-char))
  (insert " "))

(defun my-funcs/smart-delete ()
  "Delete a character. If inside an adjacent pair, also delete the according closing character.
If inside a pair with spaces, e.g. `( | )` delete both spaces symmetrically''"
  (interactive)
  (let ((preceding (string (preceding-char)))
	(following (string (following-char))))
    (if (and (equal preceding " ") (equal following " "))
	(let ((before (string (char-before (- (point) 1))))
	      (after (string (char-after (+ (point) 1)))))
	  (let ((match (cdr (assoc before my-funcs/pairs))))
	    (if (equal after match)
		(progn
		  ; between spaces and brackets -> delete both spaces first
		  (delete-backward-char 1)
		  (delete-char 1))
	      ; between spaces, but not between brackets -> normal delete
	      (delete-backward-char 1))))
      ;; we're not even between spaces, perform "normal" delete, optionally deleting a pair
      (if (my-funcs/get-pair)
 	  (electric-pair-delete-pair 1)
	(delete-backward-char 1)))))


(provide 'my-funcs)
