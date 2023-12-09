;; Welcome to the init.el of Obsidian-Roam
;; The goal of this project is to create a obsidian-esque exprience inside emacs
;; I will be using as few packages as possible




;; Set and install the packages required for the application
(setq package-list '(org org-roam))
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Stop the original startup screen 
(setq inhibit-startup-screen t)

;; This may be very controversial for people who use emacs on a daily but I am choosing to leave the tool, scroll, and menu bar there.
;; Many people including myself prefer to turn these off. Feel free to uncomment the lines bellow if you want them disabled
;; (menu-bar-mode -1) 
;; (tool-bar-mode -1) 
;; (scroll-bar-mode -1)

;;
