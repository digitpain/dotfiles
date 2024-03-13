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
(setq backup-directory-alist `(("." . "~/.emacs_backups")))

;; Check if evil is installed, if not, set up package.el for MELPA and install evil.
(require 'package)
(unless (package-installed-p 'tree-sitter-langs)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)
  (package-refresh-contents)
  (package-install 'evil)
  (package-install 'prettier-js) ;; Requires npm install -g prettier typescript-language-server javascript-typescript-langserver
  (package-install 'lsp-mode)
  (package-install 'tree-sitter)
  (package-install 'tree-sitter-langs))

(require 'evil) ;; Enable evil.
(evil-mode 1)

;; Enable JavaScript support.
(require 'tree-sitter)
(require 'tree-sitter-langs)
(tree-sitter-require 'typescript)
(add-hook 'js-mode-hook 'prettier-js-mode) ;; Enable prettier-js.
(add-hook 'js-mode-hook #'tree-sitter-hl-mode)
(add-to-list 'tree-sitter-major-mode-language-alist '(typescript-mode . typescript))
(add-hook 'js-mode-hook #'lsp) ;; Enable lsp on js.
(add-hook 'js-mode-hook #'lsp-deferred) ;; Enable lsp on js.

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
