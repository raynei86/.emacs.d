(setq inhibit-startup-message t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(set-face-attribute 'default nil :font "Hack" :height 130)
(set-face-attribute 'variable-pitch nil :family "FreeSans" :height 130)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-=") 'text-scale-increase)

(global-display-line-numbers-mode 1)
(electric-pair-mode 1)
(auto-fill-mode 1)
(show-paren-mode 1)

(setq use-dialog-box nil)
(setq ring-bell-function 'ignore)

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
(setq backup-directory-alist '(("." . "~/.config/emacs/backup/")
			       version-control t))

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu". "https://elpa.nongnu.org/nongnu/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package solarized-theme
  :config (load-theme 'solarized-light))

(defvar light-or-dark nil)
(defun toggle-theme ()
  "Toggle between dark and light theme"
  (interactive)
  (cond
   (light-or-dark
    (setq light-or-dark nil)
    (disable-theme 'solarized-light)
    (load-theme 'solarized-dark))
   (t
    (setq light-or-dark t)
    (disable-theme 'solarized-dark)
    (load-theme 'solarized-light))))


(use-package modern-cpp-font-lock
  :hook
  (c++-mode . modern-c++-font-lock-mode))

(use-package nim-mode)

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-preselect 'prompt)
  (corfu-quit-no-match 'separator)
  :init
  (global-corfu-mode))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword))
(setq-local completion-at-point-functions
	    (mapcar #'cape-company-to-capf
		    (list #'company-etags)))

(use-package vertico
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init (setq xref-show-xrefs-function #'consult-xref
              xref-show-definitions-function #'consult-xref))


(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package magit)

(use-package org-journal)
(use-package ox-pandoc)

(setq
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-ellipsis "…"
 )
(put 'downcase-region 'disabled nil)

(use-package circe)
(setq circe-network-options
      '(("Libera Chat"
         :tls t
         :nick "raynei"
         :sasl-username "raynei"
         :sasl-password "***REMOVED***"
         :channels ("#emacs")
         )))

