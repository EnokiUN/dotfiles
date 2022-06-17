; About configuring emacs.
; Some may say that taking the time to configure emacs is stupid, I mean it's true
; that emacs is old and that the manual is unholyly huge but it's not about that.
; Configuring emacs is about getting the most out of it. Additionally it's a display
; of love and affection for your editor, not taking the time to read the 1 million+
; lines of emacs source code just to be able to make a button look cooler is just
; blasphemous and straight up ungrateful.

; I'm not going to go into the details of how to configure emacs, but I'm going to
; give you a few pointers.
; 1. You can use the menu bar to access the emacs configuration menu, you should hide
; the menu bar tho because it looks shit.
; 2. You can find a gui configuration by running ``M-X customize`` but that defeats the
; point of the whole display of love yada yada yada.
; 3. You can read the manual but doing that is so retarded, the emacs manual is older than
; the year 2000 and it's so huge that it's not even funny. (github copilot said that, don't
; hold me accountable for it)
; 4. You can read the source code but you're not going to be able to understand it and if you do
; you'll be dead before you type a single character in your emacs config.
; 5. Just read other people's config's ask around for what's good and what's not, google example stuff
; and you'll be a-okay.
; 6. ***Everyone has the same config, it's just slightly different every time and it scares me***.
; 7. You can use the emacs tutorial to get a feel for emacs, it's a good way to get started. (I'm joking
; don't even try it, just install evil mode, also this isn't related to config but shhhhh).

; Now you understand why you should spend a net average of about 3 years of your life configuring
; emacs and some ways to go about it.

; You could also just use Doom Emacs which is great but invalidates my whole rant so let's act like
; it isn't a thing.

; Appearance & Misc

(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq display-line-numbers-type 'relative)
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq display-time-24hr-format t)
(setq scroll-step 1)
(setq scroll-margin 5)
(setq scroll-conservatively 9999)

(prettify-symbols-mode t)

; Packages

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(defun pack (package &rest called)
  "Install a package if it's not already installed."
  (unless (package-installed-p package)
    (when (y-or-n-p (format "Package %s is missing. Install it? " package))
      (package-install package)))
  (when (package-installed-p package)
    (if called
      (progn
        (require package)
        (apply called)))))

;; Evil Mode

(pack 'evil 'evil-mode)

;; Gruvbox Theme

(defun load-gruvbox-theme ()
  (interactive)
  (load-theme 'gruvbox-dark-hard t))

(pack 'gruvbox-theme 'load-gruvbox-theme)

;; Dired

(defun load-all-the-icons-mode ()
  (interactive)
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  (setq all-the-icons-dired-monochrome nil))

(pack 'all-the-icons-dired 'load-all-the-icons-mode)

(defun laod-diredfl-mode ()
  (interactive)
  (add-hook 'dired-mode-hook 'diredfl-mode))

(pack 'diredfl 'laod-diredfl-mode)

(pack 'fd-dired)
(pack 'ranger)

;; LSP

(defun load-lsp-mode ()
  (interactive)
  ; (add-hook 'prog-mode-hook 'lsp)
  )

(defun load-lsp-ui-mode ()
  (interactive)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(pack 'lsp-mode 'load-lsp-mode)
(pack 'lsp-ui 'load-lsp-ui-mode)
(pack 'company)
(pack 'flycheck)

;; Rust

(defun load-rust-mode ()
  (interactive)
  (setq rust-format-on-save t)
  (setq indent-tabs-mode nil)
  ; (add-hook 'rust-mode-hook 'lsp)
  )

(pack 'rust-mode 'load-rust-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rustic xterm-color rust-mode ranger projectile pfuture lsp-ui hydra gruvbox-theme flycheck fd-dired evil diredfl dired-git-info company cfrs all-the-icons-dired ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
