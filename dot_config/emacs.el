;; Aesthetic Computer Emacs Configuration, 2024.3.13.12.51

;; Open emacs maximized and with undecorated window.
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(undecorated . t))

;; Set the internal border width and color
(add-to-list 'default-frame-alist '(internal-border-width . 6)) ;; Adjust the border width as needed

(setq inhibit-startup-screen t) ;; Disable startup message.
(setq eshell-banner-message "") ;; No eshell banner.

(setq initial-scratch-message nil) ;; Empty scratch buffer message.
(global-display-line-numbers-mode) ;; Always show line numbers.

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

;; TODO: This should only be on linux.
;; (setq interprogram-cut-function
;;       (lambda (text &optional push)
;;         (with-temp-buffer
;;           (insert text)
;;           (call-process-region (point-min) (point-max) "wl-copy"))))
;; (setq interprogram-paste-function
;;       (lambda ()
;;         (shell-command-to-string "wl-paste")))

(setq-default line-spacing 0)
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

;; Initialize package sources
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install and configure use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package gruvbox-theme)
(load-theme 'gruvbox-light-medium t) ;; Set a theme.

;; Evil mode configuration
(use-package evil
  :config
  (evil-mode 1)
  (setq-default evil-shift-width 2)
  ;; override C-p in evil mode
  (dolist (state '(normal insert visual motion emacs))
    (evil-define-key state 'global (kbd "C-p") 'project-find-file)))

;;(unless (window-system)
;;  (require 'evil-terminal-cursor-changer)
;;  (evil-terminal-cursor-changer-activate)) ; Activates the cursor change
;;(setq evil-insert-state-cursor 'bar)  ; Line cursor for insert state
(unless (display-graphic-p)
        (use-package evil-terminal-cursor-changer)
        (require 'evil-terminal-cursor-changer)
        (evil-terminal-cursor-changer-activate))

(use-package helm) ;; Add helm: https://github.com/emacs-helm/helm/wiki#from-melpa  

(use-package helm
  :config
  (setq helm-M-x-fuzzy-match t) ;; Optional: Fuzzy match for M-x
  (setq helm-mode-fuzzy-match t) ;; Optional: Fuzzy match for helm-mode
  (setq helm-ff-fuzzy-matching t) ;; Enable fuzzy matching for file and buffer names
  (helm-mode 1))

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-p") #'project-find-file) ;; C-p everywhere

(global-set-key (kbd "C-<tab>") 'next-buffer) ;; Cycle buffers
(global-set-key (kbd "C-<iso-lefttab>") 'previous-buffer)

(defun my/helm-find-files-directory-handler ()
  "Open helm-find-files if Emacs is started with a directory."
  (when (and command-line-args-left (file-directory-p (car command-line-args-left)))
    (helm-find-files-1 (car command-line-args-left))
    (setq command-line-args-left nil))
  nil)

(add-to-list 'command-line-functions 'my/helm-find-files-directory-handler)

(global-set-key (kbd "M-z") 'toggle-truncate-lines) ;; alt-z for wrap.

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

;; Add more use-package blocks for other packages as needed

(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-mode)) ;; Support mjs files.

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
 '(custom-safe-themes
   '("046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012" "98ef36d4487bf5e816f89b1b1240d45755ec382c7029302f36ca6626faf44bbd" "871b064b53235facde040f6bdfa28d03d9f4b966d8ce28fb1725313731a2bcc8" default))
 '(package-selected-packages '(gptel prettier-js evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'erase-buffer 'disabled nil)
