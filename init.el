;;remove clutter/bloat base user interface

(menu-bar-mode -1) ;; menubar is no more 
(tool-bar-mode -1) ;; toolbar is dead
(scroll-bar-mode -1) ;; no scroll bar for u


;;flashbang instead of tinitus
(setq visible-bell t)

;;linenumber
(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))



;;revert buffer when changed
(global-auto-revert-mode 1)

;;nuke when ESC is pressed
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;init package source

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("elpa"  . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package command-log-mode)

;;better autocomplete
(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 20)))

(use-package doom-themes)
(load-theme 'doom-outrun-electric t)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode)


(use-package evil
  :init (evil-mode 1))
    





















(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9d5124bef86c2348d7d4774ca384ae7b6027ff7f6eb3c401378e298ce605f83a" default))
 '(package-selected-packages
   '(evil which-key rainbow-delimiters doom-themes doom-theme doom-modeline ivy command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
