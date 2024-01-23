;;remove clutter/bloat base user interface

(menu-bar-mode -1) ;; menubar is no more 
(tool-bar-mode -1) ;; toolbar is dead
(scroll-bar-mode -1) ;; no scroll bar for u


;;flashbang instead of tinitus
(setq visible-bell t)

;; global font

(set-face-attribute 'default nil :font "Firacode Nerd Font" :height 160)

;;all my homie hate  default splash screen

(setq fancy-splash-screen "~/.config/emacs/great-wave-transparent-2.png")

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


;;bootstrap use package 

(eval-after-load 'gnutls
'(add-to-list 'gnutls-trustfiles "/etc/ssl/cert.pem"))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(setq use-package-always-ensure t)



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

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)






(use-package projectile)
;; theme, modline and ico 
(use-package all-the-icons)
(use-package doom-modeline
  :ensure 
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 20)))
(use-package dashboard
  :ensure t
  :config				
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "mmmh yees not doom emacs i promise"
	dashboard-startup-banner "~/.config/emacs/great-wave-transparent-2-small.png"))
(use-package ef-themes)
(use-package doom-themes)
(load-theme 'ef-bio t)


;;better autocomplete
(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package counsel
  :init (counsel-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode)


(use-package evil
  :init (evil-mode 1))
    
(use-package magit)

(use-package hydra)

(defhydra hydra-buffer-fast-switch ()
  "switch buffer"
  ;;key
  ("n" next-buffer "next")
  ("b" previous-buffer "previous")
  ("q" nil "quit" ))
(global-set-key (kbd "C-M-j") 'hydra-buffer-fast-switch/body)

(defhydra hydra-size ()
  "size"
  ("n" ))


(use-package org)

(use-package org-bullets
  :after org)

(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (org-indent-mode 1) (org-bullets-mode 1))))
(use-package pdf-tools)










(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("46a843168cc83b28b740735516e6eea4f97769d848c79b5acab32f7a278f793a" "01aef17f41edea53c665cb57320bd80393761f836be5ab0bd53292afc94bd14d" "65af8e8d704bcd9745a4f191db756995de6b1fdd15cf2eb41befaae75f7b045d" "7d10494665024176a90895ff7836a8e810d9549a9872c17db8871900add93d5c" "5f92b9fc442528b6f106eaefa18bb5e7bfa0d737164e18f1214410fef2a6678d" "5e05db868f138062a3aedcccefe623eee18ec703ae25d4e5aebd65f892ac5bcc" "73c55f5fd22b6fd44f1979b6374ca7cc0a1614ee8ca5d4f1366a0f67da255627" "8ea6a46120abb34bf6a664b76d78014e0dd1f2b740a0976ec41313612421712f" "7964b513f8a2bb14803e717e0ac0123f100fb92160dcf4a467f530868ebaae3e" "691d671429fa6c6d73098fc6ff05d4a14a323ea0a18787daeb93fde0e48ab18b" "a6920ee8b55c441ada9a19a44e9048be3bfb1338d06fc41bce3819ac22e4b5a1" "34cf3305b35e3a8132a0b1bdf2c67623bc2cb05b125f8d7d26bd51fd16d547ec" "02d422e5b99f54bd4516d4157060b874d14552fe613ea7047c4a5cfa1288cf4f" "32f22d075269daabc5e661299ca9a08716aa8cda7e85310b9625c434041916af" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "c8b3d9364302b16318e0f231981e94cbe4806cb5cde5732c3e5c3e05e1472434" "3fe1ebb870cc8a28e69763dde7b08c0f6b7e71cc310ffc3394622e5df6e4f0da" "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd" "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" "571661a9d205cb32dfed5566019ad54f5bb3415d2d88f7ea1d00c7c794e70a36" "dd4582661a1c6b865a33b89312c97a13a3885dc95992e2e5fc57456b4c545176" "93011fe35859772a6766df8a4be817add8bfe105246173206478a0706f88b33d" "ff24d14f5f7d355f47d53fd016565ed128bf3af30eb7ce8cae307ee4fe7f3fd0" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d" "77fff78cc13a2ff41ad0a8ba2f09e8efd3c7e16be20725606c095f9a19c24d3d" "013728cb445c73763d13e39c0e3fd52c06eefe3fbd173a766bfd29c6d040f100" "0c83e0b50946e39e237769ad368a08f2cd1c854ccbcd1a01d39fdce4d6f86478" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "dccf4a8f1aaf5f24d2ab63af1aa75fd9d535c83377f8e26380162e888be0c6a9" "4e2e42e9306813763e2e62f115da71b485458a36e8b4c24e17a2168c45c9cf9d" "9d5124bef86c2348d7d4774ca384ae7b6027ff7f6eb3c401378e298ce605f83a" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(ef-themes pdf-tools treemacs-evil treemacs projectile dashboard doom-dashboard hydra all-the-icons all-the-icon counsel magit evil which-key rainbow-delimiters doom-themes doom-theme doom-modeline ivy command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
