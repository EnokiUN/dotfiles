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
(display-line-numbers-mode)
(set-face-attribute 'default nil :height 160)

(setq redisplay-dont-pause t
  scroll-margin 1
  scroll-step 1
  scroll-conservatively 9999
  scroll-preserve-screen-position 1)

(setq inhibit-startup-message t
  inhibit-startup-screen t
  initial-scratch-message nil)

(setq display-line-numbers-type 'relative)
(setq display-time-24hr-format t)
(setq ring-bell-function 'ignore)

(prettify-symbols-mode t)
 
; Packages

(require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package evil
  :ensure
  :config
  (evil-mode 1))

(use-package selectrum
  :ensure
  :config
  (selectrum-mode 1)
  )

(use-package gruvbox-theme
  :ensure
  :config
  (load-theme 'gruvbox-dark-medium))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("72ed8b6bffe0bfa8d097810649fd57d2b598deef47c992920aef8b5d9599eefe" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
