;; Aesthetic Computer Emacs Configuration, 2024.3.13.12.51

;; Open emacs maximized and with undecorated window.
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(undecorated . t))

;; Set the internal border width and color
(add-to-list 'default-frame-alist '(internal-border-width . 6)) ;; Adjust the border width as needed

(setq inhibit-startup-screen t) ;; Disable startup message.
(setq eshell-banner-message "") ;; No eshell banner.

;; (load-theme 'wombat t) ;; Set a dark theme.
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

;; Evil mode configuration
(use-package evil
  :config
  (evil-mode 1)
  (setq-default evil-shift-width 2)
  ;; override C-p in evil mode
  (dolist (state '(normal insert visual motion emacs))
    (evil-define-key state 'global (kbd "C-p") 'project-find-file)))

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

;; Add more use-package blocks for other packages as needed

(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-mode)) ;; Support mjs files.

;; Function to open eshell and run redis-server
(defun aesthetic ()
  "Open eshell and run redis-server."
  (interactive)
  (eshell)
  (insert "python3 -m http.server 8888")
  (eshell-send-input))

;; (global-set-key (kbd "C-c r") 'aesthetic) ;; Bind the function to Ctrl+c r.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(gptel prettier-js evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'erase-buffer 'disabled nil)
