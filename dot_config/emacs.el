(setq inhibit-startup-screen t) ;; Disable startup message.
(setq eshell-banner-message "") ;; No eshell banner.
(load-theme 'wombat t) ;; Set a dark theme.
(menu-bar-mode -1) ;; Disable the menu bar.
(tool-bar-mode -1) ;; Disable the tool bar.
(fringe-mode 0) ;; Disable fringe indicators.
(scroll-bar-mode -1) ;; Disable scroll bar.
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

;; Check if evil is installed, if not, set up package.el for MELPA and install evil.
(require 'package)
(unless (package-installed-p 'prettier-js)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)
  (package-refresh-contents)
  (package-install 'evil)
  (package-install 'prettier-js) ;; Requires npm install -g prettier
  ;; (package-install 'lsp-mode)
  ;;(package-install 'tree-sitter)
  ;;(package-install 'tree-sitter-langs)
  )

(require 'evil) ;; Enable evil.
(evil-mode 1)
(setq-default evil-shift-width 2)

;; Enable JavaScript support.
;;(require 'tree-sitter)
;;(require 'tree-sitter-langs)
;; Install all the latest tree-sitter grammars.
;; (tree-sitter-langs-install-latest-grammar)

;; (tree-sitter-require 'typescript)
;; (add-hook 'js-mode-hook #'tree-sitter-hl-mode)
;; (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-mode . typescript))

(add-hook 'js-mode-hook 'prettier-js-mode) ;; Enable prettier-js.
(global-set-key (kbd "C-c p") 'prettier-js)

(add-hook 'js-mode-hook 'eglot-ensure)
;; (add-hook 'typescript-mode-hook 'eglot-ensure)

;; (add-hook 'js-mode-hook #'lsp) ;; Enable lsp on js.
;; (add-hook 'js-mode-hook #'lsp-deferred) ;; Enable lsp on js.
(add-to-list 'auto-mode-alist '("\\.mjs\\'" . js-mode)) ;; Support mjs files.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(lsp-mode prettier-js evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
