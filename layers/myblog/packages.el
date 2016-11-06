;;; packages.el --- myblog layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: ovsoil <ovsoil@ovsoilmbp.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `myblog-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `myblog/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `myblog/pre-init-PACKAGE' and/or
;;   `myblog/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst myblog-packages
  '(
    (blog-admin :location (recipe
                           :fetcher github
                           :repo "codefalling/blog-admin"))
    ;; (hexo-mode :location (recipe
    ;;                  :fetcher github
    ;;                  :repo "ovsoil/hexo-mode"))
    )
  "The list of Lisp packages required by the myblog layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")


(defun myblog/init-blog-admin ()
  (use-package blog-admin
    :init
    (progn
      (setq blog-admin-backend-type 'hexo
            blog-admin-backend-path "~/Write/blog"
            blog-admin-backend-new-post-in-drafts t
            blog-admin-backend-org-page-drafts "_drafts"
            blog-admin-backend-hexo-config-file "_config.yml"
            )
      (add-hook 'blog-admin-backend-after-new-post-hook 'find-file)
      (spacemacs/set-leader-keys "abb" 'blog-admin-start)
      (setq blog-admin-backend-hexo-template-org-post
            "#+TITLE: %s
             #+AUTHOR: ovsoil
             #+EMAIL: hxyumail@126.com
             #+DATE: %s
             #+LAYOUT: post
             #+TAGS:
             #+CATEGORIES:
             #+DESCRIPTON:
             ")
      )))

(defun myblog/init-hexo-mode ()
  (use-package hexo-mode
    :init
    (progn
      (setq custom-repo-root-path "~/Write/blog/")
      ))
  )
;;; packages.el ends here
