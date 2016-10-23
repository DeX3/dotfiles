;;; package --- My custom config for backup files
;;; Commentary:
;;; Code:
(defconst my/backup-per-session-dir (expand-file-name "~/.emacs.d/backup/per-session"))
(defconst my/backup-per-save-dir (expand-file-name "~/.emacs.d/backup/per-save"))
(defconst my/autosave-dir (expand-file-name "~/.emacs.d/backup/autosave"))

(setq
 make-backup-files t
 version-control t   ; use numbers for backup files
 kept-new-versions 10
 kept-old-versions 0
 delete-old-versions t
 backup-by-copying t
 vc-make-backup-files t
 backup-directory-alist (list (cons ".*" my/backup-per-save-dir))
 auto-save-list-file-prefix my/autosave-dir
 auto-save-file-name-transforms `((".*" ,my/autosave-dir t)))

(defun my/force-backup-of-buffer ()
  ;; Make a special "per session" backup at the first save of each
  ;; emacs session.
  (when (not buffer-backed-up)
    ;; Override the default parameters for per-session backups.
    (let ((backup-directory-alist (list (cons ".*" my/backup-per-session-dir)))
          (kept-new-versions 3))
      (backup-buffer)))
  ;; Make a "per save" backup on each save.  The first save results in
  ;; both a per-session and a per-save backup, to keep the numbering
  ;; of per-save backups consistent.
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook  'my/force-backup-of-buffer)

(provide 'my-backup)
;;; my-backup.el ends here
