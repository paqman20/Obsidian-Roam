;; Welcome to the init.el of Obsidian-Roam

;;Installing use-package
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))


;; Stop the original startup screen 
(setq inhibit-startup-screen t)

;; Package install and configuration
;; ------------------------------------------------------------------------------------------------------------

;; The Star of the show. Org and Org-Roam 
;; Org-Roam is extremely powerful and it can do pretty much everything Obsidian can do. It provides the same type of file linking. There are certainly a couple differences but overall
;; The expreince is good in both of them
(use-package org
  :ensure t
;  :bind (("C-c l" . org-store-link)
   )

(use-package org-roam
  :ensure t
  :bind
  ("C-c n l" . org-roam-buffer-toggle)
  ("C-c n f" . org-roam-node-find)
  ("C-c n i" . org-roam-node-insert)
  (:map org-mode-map
        (("C-c n i" . org-roam-node-insert)))
  :config
  (setq org-roam-capture-templates `(("d" "default" plain "%?" :target (file+head "${slug}.org" "#+title: ${title}"):unnarrowed t))) 
  )
;; Treemacs
;; A use package declaration this is going to help us autmatically set everything up. Use-Package is pretty sweet.
;; Like I stated in the README. There are alot of things here I dont need. Things like magit however im going to still be including it
;; It is a powerful application. Besides many people migth want to research magit as it is also extremly powerful.

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

;; Automatically start treemacs on startup
(treemacs)

;; Markdown
;; This is the package that will allow you to continue using markdown. In my opinion I reccomend learning org bu this will let you migrate your notes. 
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))
(require 'markdown-mode)

;; Adding obsidian colors to the headings
(custom-set-faces
  '(markdown-header-face-1 ((t (:foreground "blue")))) 
  '(markdown-header-face-2 ((t (:foreground "green")))) 
  '(markdown-header-face-3 ((t (:foreground "orange"))))
  '(markdown-header-face-4 ((t (:foreground "yellow"))))
  '(markdown-header-face-5 ((t (:foreground "purple"))))
  )

;;-------------------------------------------------------------------------------------------------------------

;; Default Behaviors
;;-------------------------------------------------------------------------------------------------------------
;; This may be very controversial for people who use emacs on a daily but I am choosing to leave the menu bar there.
;; Many people including myself prefer to turn these off. Feel free to uncomment the lines bellow if you want them disabled
;; (menu-bar-mode -1) 
(tool-bar-mode -1) 
(scroll-bar-mode -1)

;; Turn on visual line wrapping and fylspell in ALL org-mode files
(add-hook 'org-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-visual-line-mode)
;; Turn on visual line wrapping and fylspell in ALL markdown-mode files
(add-hook 'markdown-mode-hook 'turn-on-flyspell)
(add-hook 'markdown-mode-hook 'turn-on-visual-line-mode)




