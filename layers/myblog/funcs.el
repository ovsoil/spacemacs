(when (configuration-layer/package-usedp 'hexo-mode)
  (defun hexo-my-blog ()
    (interactive)
    (hexo "~/Write/blog/"))

  ;;;;; Prefix
  (define-key hexo-mode-map (kbd "T") nil)
  (define-key hexo-mode-map (kbd "s") nil)
  (define-key hexo-mode-map (kbd "M") nil)
  ;; Files
  (define-key hexo-mode-map (kbd "RET") 'hexo-command-open-file)
  (define-key hexo-mode-map (kbd "SPC") 'hexo-command-show-article-info)
  (define-key hexo-mode-map (kbd "N") 'hexo-new)
  (define-key hexo-mode-map (kbd "R") 'hexo-command-rename-file)
  (define-key hexo-mode-map (kbd "<f2>") 'hexo-command-rename-file)
  ;; View
  (define-key hexo-mode-map (kbd "g") 'hexo-command-revert-tabulated-list)
  (define-key hexo-mode-map (kbd "S") 'tabulated-list-sort)
  (define-key hexo-mode-map (kbd "f") 'hexo-command-filter-tag)
  ;; Edit
  (define-key hexo-mode-map (kbd "T T") 'hexo-touch-files-in-dir-by-time)
  (define-key hexo-mode-map (kbd "T S") 'hexo-toggle-article-status)
  (define-key hexo-mode-map (kbd "t") 'hexo-command-tags-toggler)
  ;; Marks
  (define-key hexo-mode-map (kbd "m") 'hexo-command-mark)
  (define-key hexo-mode-map (kbd "u") 'hexo-command-unmark)
  (define-key hexo-mode-map (kbd "M a") 'hexo-command-add-tags)
  (define-key hexo-mode-map (kbd "M r") 'hexo-command-remove-tags)
  ;; Server
  (define-key hexo-mode-map (kbd "s r") 'hexo-server-run)
  (define-key hexo-mode-map (kbd "s s") 'hexo-server-stop)
  (define-key hexo-mode-map (kbd "s d") 'hexo-server-deploy)
  ;; Modes
  (define-key hexo-mode-map (kbd "h") 'hexo-command-quick-help)
  (define-key hexo-mode-map (kbd "?") 'hexo-command-quick-help)
  (define-key hexo-mode-map (kbd "Q") 'kill-buffer-and-window)

  (defun hexo-get-help-string ()
    (let* ((help-str (concat
                      (propertize
                       "File             View              Edit                 Mark                Server             Mode\n" 'face 'header-line)
                      "[RET] Open       [  g] Refresh     [T T] Touch time     [  m] Mark          [s r] Run server   [  ?] Show this help\n"
                      "[SPC] Show Info  [  S] Sort        [T S] Toggle status  [  u] Unmark        [s s] Stop server  [  Q] Quit\n"
                      "[  N] New        [  f] Filter tag  [  t] Tags toggler   [M a] Add tags      [s d] Deploy\n"
                      "[  R] Rename                                            [M r] Remove tags"))
           (help-str-without-brackets (replace-regexp-in-string "[][]" " " help-str 'fixedcase)))
      (mapc (lambda (begin-end)
              (add-face-text-property (car begin-end)
                                      (cdr begin-end)
                                      '(face 'hexo-status-post)
                                      t help-str-without-brackets))
            (hexo-string-match-positions "\\(\\[.+?\\]\\)" help-str 1)) ;all position
      help-str-without-brackets))

  (defun hexo-command-quick-help ()
    "Show quick help message."
    (interactive)
     (message (hexo-get-help-string)))
  )
