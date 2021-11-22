;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
; (setq doom-theme 'doom-one)

(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(use-package lsp-mode :ensure t)
(use-package lsp-ui :ensure t) ;; UI for LSP
(use-package company :ensure t) ;; Auto-complete


; (require 'lsp-python-ms)
; (setq lsp-python-ms-auto-install-server t)
; (add-hook 'python-mode-hook #'lsp) ; or lsp-deferred


(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred


; (use-package lsp-python-ms
;   :ensure t
;   :init (setq lsp-python-ms-auto-install-server t)
;   :hook (python-mode . (lambda ()
;                           (require 'lsp-python-ms)
;                           (lsp))))  ; or lsp-deferred

; (use-package lsp-dart
;   :ensure t
;   :hook (dart-mode . lsp))
(setq package-selected-packages 
  '(dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company
    ;; Optional packages
    lsp-ui company hover))

(add-hook 'dart-mode-hook 'lsp)
(with-eval-after-load "projectile"
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))


(setq projectile-project-search-path '("~/Projects/"))

; (when (display-graphic-p)
;   (setq user-font
;         (cond
;          ((find-font (font-spec :name  "CartographCF Nerd Font")) "CartographCF Nerd Font")
;          ((find-font (font-spec :name  "OperatorMono Nerd Font")) "OperatorMono Nerd Font")
;          ((find-font (font-spec :name  "Droid Sans Mono")) "Droid Sans Mono")
;          ((find-font (font-spec :name  "Droid Sans Fallback")) "Droid Sans Fallback")))

(setq doom-font (font-spec :family "JetBrainsMono" :size 15 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Noto Serif" :size 15)
      ivy-posframe-font (font-spec :family "JetBrainsMono" :size 15))




; (use-package dart-mode
;   :ensure-system-package (dart_language_server . "pub global activate dart_language_server")
;   :hook (dart-mode . (lambda ()
;                       (add-hook 'after-save-hook #'flutter-run-or-hot-reload nil t)))
;   :custom
;   (dart-format-on-save t)
;   (dart-sdk-path "/home/holyraven/Android/flutter/bin/cache/dart-sdk/"))


(add-hook 'js2-mode-hook 'lsp)

(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)


