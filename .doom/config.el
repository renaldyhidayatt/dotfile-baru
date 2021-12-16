(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")


(setq doom-theme 'doom-one)


(setq org-directory "~/org/")


(setq display-line-numbers-type t)


(use-package lsp-mode :ensure t)
(use-package lsp-ui :ensure t) ;; UI for LSP
(use-package company :ensure t)


;; (use-package highlight-indentation-mode :ensure t)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or 



(use-package pipenv
  :hook (python-mode . pipenv-mode)
  :init
  (setq
   pipenv-projectile-after-switch-function
   #'pipenv-projectile-after-switch-extended))

(after! lsp-pyright
(setq lsp-pyright-python-executable-cmd "python3"))


;; (setq projectile-track-known-projects-automatically nil)

;; (setq projectile-project-search-path '("~/Projects/" "~/work/" ("~/github" . 1)))


(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)

(setq prettier-js-args '(
  "--trailing-comma" "all"
  "--bracket-spacing" "false"
))

(eval-after-load 'web-mode
    '(progn
       (add-hook 'web-mode-hook #'add-node-modules-path)
       (add-hook 'web-mode-hook #'prettier-js-mode)))



(setq doom-font (font-spec :family "JetBrainsMono" :size 15 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono" :size 15)
      ivy-posframe-font (font-spec :family "JetBrainsMono" :size 15))

