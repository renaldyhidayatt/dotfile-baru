
(require 'package)

(setq package-archives '
    (
        ("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))


(package-initialize)
(unless package-archive-contents
    (package-refresh-contents))

;;Initializeuse-packageonnon-Linuxplatforms
(unless 
    (package-installed-p 'use-package)
    (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;;Setupthevisiblebell
(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)



;;Themes
(use-package doom-themes
:init
    (load-theme 'doom-gruvbox t))


(use-package doom-modeline
:init
    (doom-modeline-mode 1)
:custom
    (
        (doom-modeline-height 15)))


(use-package general
:config
    (general-evil-setup t))


(use-package evil
:init;;tweakevil'sconfigurationbeforeloadingit
    (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
    (setq evil-want-keybinding nil)
    (setq evil-vsplit-window-right t)
    (setq evil-split-window-below t)
    (evil-mode))


(use-package all-the-icons
:if
    (display-graphic-p))



(use-package which-key
:init
    (setq which-key-side-window-location 'bottom
which-key-sort-order#'which-key-key-order-alpha
which-key-sort-uppercase-firstnil
which-key-add-column-padding1
which-key-max-display-columnsnil
which-key-min-display-lines6
which-key-side-window-slot-10
which-key-side-window-max-height0.25
which-key-idle-delay0.8
which-key-max-description-length25
which-key-allow-imprecise-window-fitt
which-key-separator" → "))
(which-key-mode)



(winner-mode 1)

;;Usinggarbagemagichack.
(use-package gcmh
:config
    (gcmh-mode 1))


;;Settinggarbagecollectionthreshold
(setq gc-cons-threshold 402653184
gc-cons-percentage0.6)

;;Profileemacsstartup
(add-hook 'emacs-startup-hook
    (lambda 
        ()
        (message "*** Emacs loaded in %s with %d garbage collections."
            (format "%.2f seconds"
                (float-time
                    (time-subtract after-init-time before-init-time)))
gcs-done)))


;;Commenter
(use-package evil-nerd-commenter)



;;DashboardEmacs
(use-package dashboard
:init;;tweakdashboardconfigbeforeloadingit
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
;;    (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
    (setq dashboard-startup-banner "~/.emacs.d/emacs-dash.png")  ;; use custom image as banner
    (setq dashboard-center-content nil) ;; set to 't' for centered content
    (setq dashboard-items '
        (
            (recents . 5)
            (agenda . 5 )
            (bookmarks . 3)
            (projects . 3)
            (registers . 3)))
:config
    (dashboard-setup-startup-hook)
    (dashboard-modify-heading-icons '
        (
            (recents . "file-text")
            (bookmarks . "book"))))

(setq initial-buffer-choice 
    (lambda 
        () 
        (get-buffer "*dashboard*")))

;;Silencecompilerwarningsastheycanbeprettydisruptive
(if 
    (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation nil)
    (setq native-comp-deferred-compilation nil))
;;Innoninteractivesessions,prioritizenon-byte-compiledsourcefilesto
;;preventtheuseofstalebyte-code.Otherwise,itsavesusalittleIOtime
;;toskipthemtimechecksonevery*.elcfile.
(setq load-prefer-newer noninteractive)



;;CustomVariable

(custom-set-variables
;;custom-set-variableswasaddedbyCustom.
;;Ifyouedititbyhand,youcouldmessitup,sobecareful.
;;Yourinitfileshouldcontainonlyonesuchinstance.
;;Ifthereismorethanone,theywon'tworkright.
'
    (package-selected-packages
'
        (magit pipenv highlight-indent-guides projectile ivy-posframe python-mode company-box company lsp-ivy lsp-ui lsp-mode flycheck-popup-tip flycheck-posframe flycheck popup-kill-ring vterm neotree go-mode all-the-icons-dired peep-dired dired-open doom-themes use-package)))
(custom-set-faces
;;custom-set-faceswasaddedbyCustom.
;;Ifyouedititbyhand,youcouldmessitup,sobecareful.
;;Yourinitfileshouldcontainonlyonesuchinstance.
;;Ifthereismorethanone,theywon'tworkright.
'
    (flycheck-posframe-face 
        (
            (t 
                (:foreground "#b8bb26"))))
'
    (flycheck-posframe-info-face 
        (
            (t 
                (:foreground "#b8bb26"))))
'
    (lsp-ui-doc-background 
        (
            (t 
                (:background nil))))
'
    (lsp-ui-doc-header 
        (
            (t 
                (:inherit 
                    (font-lock-string-face italic))))))



;;Directory
(use-package all-the-icons-dired)
(use-package dired-open)
(use-package peep-dired)


(with-eval-after-load 'dired
;;    (define-key dired-mode-map 
        (kbd "M-p") 'peep-dired)
    (evil-define-key 'normal dired-mode-map 
        (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map 
        (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
    (evil-define-key 'normal peep-dired-mode-map 
        (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map 
        (kbd "k") 'peep-dired-prev-file))

(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;;Getfileiconsindired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)


;;Git
(setq bare-git-dir 
    (concat "--git-dir=" 
        (expand-file-name "~/.dotfiles")))
(setq bare-work-tree 
    (concat "--work-tree=" 
        (expand-file-name "~")))
;;usemaggitongitbarereposlikedotfilesrepos,don'tforgettochange`bare-git-dir'and`bare-work-tree'toyourneeds
(defun me/magit-status-bare 
    ()
"set --git-dir and --work-tree in `magit-git-global-arguments' to `bare-git-dir' and `bare-work-tree' and calls `magit-status'"
    (interactive)
    (require 'magit-git)
    (add-to-list 'magit-git-global-arguments bare-git-dir)
    (add-to-list 'magit-git-global-arguments bare-work-tree)
    (call-interactively 'magit-status))

;;ifyouuse`me/magit-status-bare'youcantuse`magit-status'onotherotherreposyouhavetounset`--git-dir'and`--work-tree'
;;use`me/magit-status'insteditunsetsthosebeforecalling`magit-status'
(defun me/magit-status 
    ()
"removes --git-dir and --work-tree in `magit-git-global-arguments' and calls `magit-status'"
    (interactive)
    (require 'magit-git)
    (setq magit-git-global-arguments 
        (remove bare-git-dir magit-git-global-arguments))
    (setq magit-git-global-arguments 
        (remove bare-work-tree magit-git-global-arguments))
    (call-interactively 'magit-status))

(use-package magit)




;;SetupFonts
(set-face-attribute 'default nil
:font"JetBrainsMono"
:height100
:weight'regular)
(set-face-attribute 'variable-pitch nil
:font"JetBrainsMono"
:height100
:weight'regular)
(set-face-attribute 'fixed-pitch nil
:font"JetBrainsMono"
:height100
:weight'regular)
;;Makescommentedtextandkeywordsitalics.
;;Thisisworkinginemacsclientbutnotemacs.
;;Yourfontmusthaveanitalicfaceavailable.
(set-face-attribute 'font-lock-comment-face nil
:slant'italic)
(set-face-attribute 'font-lock-keyword-face nil
:slant'italic)

;;Uncommentthefollowinglineiflinespacingneedsadjusting.
(setq-default line-spacing 0.03)

(setq user-full-name "renaldyhidayatt")
(setq user-mail-address "renaldyhidayatt@gmail.com")

;;Neededifusingemacsclient.Otherwise,yourfontswillbesmallerthanexpected.
(add-to-list 'default-frame-alist '
    (font . "JetBrainsMono-11"))
;;changescertainkeywordstosymbols,suchaslamda!
(setq global-prettify-symbols-mode t)


(use-package neotree
:config
    (setq neo-smart-open t
neo-window-width30
neo-theme
        (if 
            (display-graphic-p) 'icons 'arrow)
;;neo-window-fixed-sizenil
inhibit-compacting-font-cachest
projectile-switch-project-action'neotree-projectile-action)
;;truncatelongfilenamesinneotree
    (add-hook 'neo-after-create-hook
#'
        (lambda 
            (_)
            (with-current-buffer 
                (get-buffer neo-buffer-name)
                (setq truncate-lines t)
                (setq word-wrap nil)
                (make-local-variable 'auto-hscroll-mode)
                (setq auto-hscroll-mode nil)))))


(use-package vterm)
(setq shell-file-name "/bin/fish"
vterm-max-scrollback5000)

(use-package popup-kill-ring
:bind
    ("M-y" . popup-kill-ring))


;;showhiddenfiles
(setq-default neo-show-hidden-files t)

;;Config
(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '
    (3 
        (
            (shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;;Withdired-openplugin,youcanlaunchexternalprogramsforcertainextensions
;;Forexample,Isetall.pngfilestoopenin'sxiv'andall.mp4filestoopenin'mpv'
(setq dired-open-extensions '
    (
        ("gif" . "sxiv")
        ("jpg" . "sxiv")
        ("png" . "sxiv")
        ("mkv" . "mpv")
        ("mp4" . "mpv")))

(defcustom neo-window-width 25
"*Specifies the width of the NeoTree window."
:type'integer
:group'neotree)

(setq org-src-fontify-natively t
org-src-tab-acts-nativelyt
org-confirm-babel-evaluatenil
org-edit-src-content-indentation0)




;;;Projectile

(use-package projectile
:config
    (projectile-global-mode 1))


(use-package pipenv
:hook
    (python-mode . pipenv-mode)
:init
    (setq
pipenv-projectile-after-switch-function
#'pipenv-projectile-after-switch-extended))





(use-package flycheck
:defert
:diminish
:hook
    (after-init . global-flycheck-mode)
:commands
    (flycheck-add-mode)
:custom
    (flycheck-global-modes
'
        (not outline-mode diff-mode shell-mode eshell-mode term-mode))
    (flycheck-emacs-lisp-load-path 'inherit)
    (flycheck-indication-mode 
        (if 
            (display-graphic-p) 'right-fringe 'right-margin))
:init
    (if 
        (display-graphic-p)
        (use-package flycheck-posframe
:custom-face
            (flycheck-posframe-face 
                (
                    (t 
                        (:foreground ,
                            (face-foreground 'success)))))
            (flycheck-posframe-info-face 
                (
                    (t 
                        (:foreground ,
                            (face-foreground 'success)))))
:hook
            (flycheck-mode . flycheck-posframe-mode)
:custom
            (flycheck-posframe-position 'window-bottom-left-corner)
            (flycheck-posframe-border-width 3)
            (flycheck-posframe-inhibit-functions
'
                (
                    (lambda 
                        (&rest _) 
                        (bound-and-true-p company-backend)))))
        (use-package flycheck-pos-tip
:definesflycheck-pos-tip-timeout
:hook
            (flycheck-mode . flycheck-pos-tip-mode)
:custom
            (flycheck-pos-tip-timeout 30)))
:config
    (use-package flycheck-popup-tip
:hook
        (flycheck-mode . flycheck-popup-tip-mode))
    (when 
        (fboundp 'define-fringe-bitmap)
        (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
[16481122401124816]nilnil'center))
    (when 
        (executable-find "vale")
        (use-package flycheck-vale
:config
            (flycheck-vale-setup)
            (flycheck-add-mode 'vale 'latex-mode))))


;;Lsp

(use-package lsp-mode
:defert
:commandslsp
:custom
    (lsp-keymap-prefix "C-x l")
    (lsp-auto-guess-root nil)
    (lsp-prefer-flymake nil) ; Use flycheck instead of flymake
    (lsp-enable-file-watchers nil)
    (lsp-enable-folding nil)
    (read-process-output-max 
        (* 1024 1024))
    (lsp-keep-workspace-alive nil)
    (lsp-eldoc-hook nil)
:bind
    (:map lsp-mode-map 
        ("C-c C-f" . lsp-format-buffer))
:hook
    (
        (python-mode go-mode rust-mode
js-modejs2-modetypescript-modeweb-mode).lsp-deferred)
:config
    (defun lsp-update-server 
        ()
"Update LSP server."
        (interactive)
;;Equalsto`C-uM-xlsp-install-server'
        (lsp-install-server t)))


(require 'lsp-mode)

(use-package lsp-ui
:afterlsp-mode
:diminish
:commandslsp-ui-mode
:custom-face
    (lsp-ui-doc-background 
        (
            (t 
                (:background nil))))
    (lsp-ui-doc-header 
        (
            (t 
                (:inherit 
                    (font-lock-string-face italic)))))
:bind
    (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
        ([remap xref-find-references] . lsp-ui-peek-find-references)
        ("C-c u" . lsp-ui-imenu)
        ("M-i" . lsp-ui-doc-focus-frame))
    (:map lsp-mode-map
        ("M-n" . forward-paragraph)
        ("M-p" . backward-paragraph))
:custom
    (lsp-ui-doc-header t)
    (lsp-ui-doc-include-signature t)
    (lsp-ui-doc-border 
        (face-foreground 'default))
    (lsp-ui-sideline-enable nil)
    (lsp-ui-sideline-ignore-duplicate t)
    (lsp-ui-sideline-show-code-actions nil)
:config
;;Uselsp-ui-doc-webkitonlyinGUI
    (when 
        (display-graphic-p)
        (setq lsp-ui-doc-use-webkit t))
;;WORKAROUNDHidemode-lineofthelsp-ui-imenubuffer
;;https://github.com/emacs-lsp/lsp-ui/issues/243
    (defadvice lsp-ui-imenu 
        (after hide-lsp-ui-imenu-mode-line activate)
        (setq mode-line-format nil))
;;`C-g'toclosedoc
    (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide))

(setq lsp-ui-doc-position 'bottom)

;;(setq lsp-headerline-breadcrumb-segments 'symbol)

(use-package lsp-ivy)

(use-package company
:afterlsp-mode
:hook
    (prog-mode . company-mode)
:bind
    (:map company-active-map
        ("<tab>" . company-complete-selection))
    (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
:custom
    (company-minimum-prefix-length 1)
    (company-idle-delay 0.0))

(use-package company-box
:hook
    (company-mode . company-box-mode))



;;Language

(use-package python-mode
:ensuret
:hook
    (python-mode . lsp-deferred)
:afterflycheck
:mode"\\.py\\'"
:custom
    (python-indent-offset 4)
    (flycheck-python-pycompile-executable "python")
    (python-shell-interpreter "python"))



(use-package go-mode
:ensuret
;;:afterflycheck
:mode"\\.go\\'"
:hook
    (before-save . gofmt-before-save)
:custom
    (gofmt-command "goimports")
    (flycheck-go-build-tags "golang"))

(setq lsp-gopls-server-path "/home/holyraven/go/bin/gopls")



(defun lsp-go-install-save-hooks 
    ()
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(add-hook 'go-mode-hook #'lsp-deferred)

(use-package js2-mode
:mode"\\.js\\'"
:interpreter"node")

(use-package typescript-mode
:mode"\\.ts\\'"
:commands
    (typescript-mode))

(use-package rust-mode
:mode"\\.rs\\'"
:custom
    (rust-format-on-save t)
:config
    (use-package flycheck-rust
:afterflycheck
:config
        (with-eval-after-load 'rust-mode
            (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))))


(use-package emmet-mode
:hook
    (
        (web-mode . emmet-mode)
        (css-mode . emmet-mode)))


(use-package web-mode
:custom-face
    (css-selector 
        (
            (t 
                (:inherit default :foreground "#66CCFF"))))
    (font-lock-comment-face 
        (
            (t 
                (:foreground "#828282"))))
:mode
    ("\\.phtml\\'" "\\.tpl\\.php\\'" "\\.[agj]sp\\'" "\\.as[cp]x\\'"
"\\.erb\\'""\\.mustache\\'""\\.djhtml\\'""\\.[t]?html?\\'"))


;;Formatting
(use-package format-all)


;;
(use-package counsel
:afterivy
:config
    (counsel-mode))



(use-package ivy
:defer0.1
:diminish
:bind
    (        ("C-c C-r" . ivy-resume)
        ("C-x B" . ivy-switch-buffer-other-window))
:custom
    (setq ivy-count-format "%d/%d ")
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
:config
    (ivy-mode))


(use-package ivy-rich
:afterivy
:custom
    (ivy-virtual-abbreviate 'full
ivy-rich-switch-buffer-align-virtual-buffert
ivy-rich-path-style'abbrev)
:config
    (ivy-set-display-transformer 'ivy-switch-buffer
'ivy-rich-switch-buffer-transformer)
    (ivy-rich-mode 1)) ;; this gets us descriptions in M-x.


(use-package swiper
:afterivy
:bind
    (
        ("C-s" . swiper)
        ("C-r" . swiper)))



(use-package ivy-posframe
:init
    (setq ivy-posframe-display-functions-alist
'
        (
            (swiper                     . ivy-posframe-display-at-point)
            (complete-symbol            . ivy-posframe-display-at-point)
            (counsel-M-x                . ivy-display-function-fallback)
            (counsel-esh-history        . ivy-posframe-display-at-window-center)
            (counsel-describe-function  . ivy-display-function-fallback)
            (counsel-describe-variable  . ivy-display-function-fallback)
            (counsel-find-file          . ivy-display-function-fallback)
            (counsel-recentf            . ivy-display-function-fallback)
            (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
            (dmenu                      . ivy-posframe-display-at-frame-top-center)
            (nil                        . ivy-posframe-display))
ivy-posframe-height-alist
'
        (
            (swiper . 20)
            (dmenu . 20)
            (t . 10)))
:config
    (ivy-posframe-mode 1)) ; 1 enables posframe-mode, 0 disables it.


(use-package highlight-indent-guides
:if
    (display-graphic-p)
:diminish
;;Enablemanuallyifneeded,itaseverebugwhichpotentiallycore-dumpsEmacs
;;https://github.com/DarthFennec/highlight-indent-guides/issues/76
:commands
    (highlight-indent-guides-mode)
:custom
    (highlight-indent-guides-method 'character)
    (highlight-indent-guides-responsive 'top)
    (highlight-indent-guides-delay 0)
    (highlight-indent-guides-auto-character-face-perc 7))


(setq-default indent-tabs-mode nil)
(setq-default indent-line-function 'insert-tab)
(setq-default tab-width 4)
(setq-default js-switch-indent-offset 4)
(defun smart-electric-indent-mode 
    ()
"Disable 'electric-indent-mode in certain buffers and enable otherwise."
    (cond 
        (
            (and 
                (eq electric-indent-mode t)
                (member major-mode '
                    (erc-mode text-mode)))
            (electric-indent-mode 0))
        (            (eq electric-indent-mode nil) 
            (electric-indent-mode 1))))
(add-hook 'post-command-hook #'smart-electric-indent-mode)


(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)






;;Keybind

(nvmap :prefix "SPC"
"/"'
    (evilnc-comment-or-uncomment-lines :which-key "Comment")
)

(nvmap :prefix "SPC"
;;Windowsplits
"w c"'
    (evil-window-delete :which-key "Close window")
"w n"'
    (evil-window-new :which-key "New window")
"w s"'
    (evil-window-split :which-key "Horizontal split window")
"w v"'
    (evil-window-vsplit :which-key "Vertical split window")
;;Windowmotions
"w h"'
    (evil-window-left :which-key "Window left")
"w j"'
    (evil-window-down :which-key "Window down")
"w k"'
    (evil-window-up :which-key "Window up")
"w l"'
    (evil-window-right :which-key "Window right")
"w w"'
    (evil-window-next :which-key "Goto next window")
;;winnermode
"w <left>"'
    (winner-undo :which-key "Winner undo")
"w <right>"'
    (winner-redo :which-key "Winner redo"))


(nvmap :prefix "SPC"
"b b"'
    (ibuffer :which-key "Ibuffer")
"b c"'
    (clone-indirect-buffer-other-window :which-key "Clone indirect buffer other window")
"b k"'
    (kill-current-buffer :which-key "Kill current buffer")
"b n"'
    (next-buffer :which-key "Next buffer")
"b p"'
    (previous-buffer :which-key "Previous buffer")
"b B"'
    (ibuffer-list-buffers :which-key "Ibuffer list buffers")
"b K"'
    (kill-buffer :which-key "Kill buffer"))



(nvmap :states '
    (normal visual) :keymaps 'override :prefix "SPC"
"d d"'
    (dired :which-key "Open dired")
"d j"'
    (dired-jump :which-key "Dired jump to current")
"d p"'
    (peep-dired :which-key "Peep-dired"))

(nvmap :states '
    (normal visual) :keymaps 'override :prefix "SPC"
"."'
    (find-file :which-key "Find file")
"f f"'
    (find-file :which-key "Find file")
"f r"'
    (counsel-recentf :which-key "Recent files")
"f s"'
    (save-buffer :which-key "Save file")
"f u"'
    (sudo-edit-find-file :which-key "Sudo find file")
"f y"'
    (dt/show-and-copy-buffer-path :which-key "Yank file path")
"f C"'
    (copy-file :which-key "Copy file")
"f D"'
    (delete-file :which-key "Delete file")
"f R"'
    (rename-file :which-key "Rename file")
"f S"'
    (write-file :which-key "Save file as...")
"f U"'
    (sudo-edit :which-key "Sudo edit file"))


(nvmap :keymaps 'override :prefix "SPC"
"SPC"'
    (counsel-M-x :which-key "M-x")
"c c"'
    (compile :which-key "Compile")
"c C"'
    (recompile :which-key "Recompile")
"h r r"'
    (
        (lambda 
            () 
            (interactive) 
            (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
"t t"'
    (toggle-truncate-lines :which-key "Toggle truncate lines"))



(nvmap :prefix "SPC"
"t n"'
    (neotree-toggle :which-key "Toggle neotree file viewer")
"d n"'
    (neotree-dir :which-key "Open directory in neotree"))
