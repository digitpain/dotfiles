;; Aesthetic Computer Emacs Configuration, 2024.3.13.12.51

;; Open emacs maximized and with undecorated window.
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(undecorated . t))

(desktop-save-mode 1)
(setq desktop-save 'if-exists)
(setq desktop-dirname "~/.emacs.d/desktop/")

(tab-bar-mode t) ;; Enable the tab bar mode.
(setq tab-bar-new-tab-choice "*dashboard*")
(setq tab-bar-hints t)
(setq tab-bar-format '(tab-bar-format-history
                       tab-bar-format-tabs
                       tab-bar-separator))
(setq tab-bar-close-button-show nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tab-bar ((t (:height 1.2)))))

;; modeline settings
'(mode-line ((t (:underline nil :overline nil :box (:line-width 8 :color "#353644" :style nil) :foreground "white" :background "#353644"))))

(setq inhibit-startup-screen t) ;; Disable startup message.
(setq eshell-banner-message "") ;; No eshell banner.

(setq initial-scratch-message nil) ;; Empty scratch buffer message.

(global-display-line-numbers-mode) ;; Always show line numbers.

(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-mode)) ;; Support mjs files.

(defun disable-line-numbers-in-eshell () ;; Except when in an `eshell`.
  "Disable line numbers in eshell."
  (when (derived-mode-p 'eshell-mode)
    (display-line-numbers-mode -1)))

(add-hook 'eshell-mode-hook 'disable-line-numbers-in-eshell)

;; Only show emergency warnings.
(add-hook 'after-init-hook
          (lambda ()
            (setq warning-minimum-level :emergency)))

(when (window-system)
  (fringe-mode 0) ;; Disable fringe indicators.
  (scroll-bar-mode -1)) ;; Disable scroll bar.

(menu-bar-mode -1) ;; Disable the menu bar.
(tool-bar-mode -1) ;; Disable the tool bar.

;; (setq-default line-spacing 0)
(xterm-mouse-mode 1)
(defun track-mouse (e))
(setq mouse-sel-mode t)
(setq ring-bell-function 'ignore) ;; Ignore scroll bell.

;; Set-up a better backup directory.
(defvar my-backup-directory "~/.emacs.d/backups/")
(unless (file-exists-p my-backup-directory)
  (make-directory my-backup-directory t))
(setq backup-directory-alist `(("." . ,my-backup-directory)))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq vc-follow-symlinks t)

(global-set-key (kbd "M-z") 'toggle-truncate-lines) ;; Line truncation. 
(add-hook 'after-init-hook (lambda () (setq-default truncate-lines t)))

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; 🪄 Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install and configure use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package helm ;; Add helm: https://github.com/emacs-helm/helm/wiki#from-melpa  
  :config
  (setq helm-M-x-fuzzy-match t) ;; Optional: Fuzzy match for M-x
  (setq helm-mode-fuzzy-match t) ;; Optional: Fuzzy match for helm-mode
  (setq helm-ff-fuzzy-matching t) ;; Enable fuzzy matching for file and buffer names
  (helm-mode 1))

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-p") #'project-find-file) ;; C-p everywhere

(defun my/helm-find-files-directory-handler ()
  "Open helm-find-files if Emacs is started with a directory."
  (when (and command-line-args-left (file-directory-p (car command-line-args-left)))
    (helm-find-files-1 (car command-line-args-left))
    (setq command-line-args-left nil))
  nil)

(add-to-list 'command-line-functions 'my/helm-find-files-directory-handler)

(use-package s) ;; `dockerfile-mode` depends on `s`.
(use-package dockerfile-mode) ;; Dockerfile support.
(use-package fish-mode) ;; Fish shell syntax.
;; (use-package gptel) ;; ChatGPT / LLM support. 
(use-package chatgpt-shell
  :custom
  ((chatgpt-shell-openai-key
    (lambda ()
      (getenv "OPENAI_API_KEY")))))
;; ^ Set via `set -Ux OPENAI_API_KEY "your_api_key_here"` in fish shell.

;; Prettier-js configuration
(use-package prettier-js
  :hook (js-mode . prettier-js-mode)
  :bind ("C-c p" . prettier-js))

;; Use good clipboard system in terminal mode.
(use-package clipetty
 :ensure t
 :hook (after-init . global-clipetty-mode))

;; Evil mode configuration
(use-package evil
  :config
  (evil-mode 1)
  (setq-default evil-shift-width 2)
  ;; override C-p in evil mode
  (dolist (state '(normal insert visual motion emacs))
    (evil-define-key state 'global (kbd "C-p") 'project-find-file)))

(unless (display-graphic-p)
        (use-package evil-terminal-cursor-changer)
        (require 'evil-terminal-cursor-changer)
        (evil-terminal-cursor-changer-activate))

(use-package restart-emacs) ;; Fully restart emacs: https://github.com/iqbalansari/restart-emacs 
(setq restart-emacs-restore-frames t)
(global-set-key (kbd "C-c C-r") 'restart-emacs)

(global-set-key (kbd "C-c C-o") 'browse-url-at-point) ;; Open url.

(use-package auto-dark)
(setq auto-dark-dark-theme 'wombat
      auto-dark-light-theme 'whiteboard)
(auto-dark-mode t)

;; (use-package burly)

;; This package breaks terminal rendering :(
;; (use-package gruvbox-theme)
(load-theme 'whiteboard t) ;; Set a theme.

;; 🫀 Aesthetic Computer Layouts

;; Function to open eshell and run redis-server
(defun aesthetic ()
  "Open eshell and run redis-server."
  (interactive)
  (eshell)
  (insert "python3 -m http.server 8888")
  (eshell-send-input))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-terminal-cursor-changer restart-emacs prettier-js helm fish-mode evil dockerfile-mode clipetty chatgpt-shell)))
