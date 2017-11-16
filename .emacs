;; Arthur Nguyen <arth.nguyen@gmail.com>

;;;;;;;;;;;;;;;;;;;;;;;;
;; Packages
;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(require 'cl)

(defvar required-packages
  '(
    highlight-parentheses
    git-gutter
    git-commit
    flycheck
    yaml-mode
    coffee-mode
    php-mode
  ) "a list of packages to ensure are installed at launch.")

; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(require 'flycheck)
(add-hook 'after-init-hook 'global-flycheck-mode)
(setq flycheck-highlighting-mode 'lines)
(defadvice flycheck-start-checker (around flycheck-fix-start-process activate compile)
  "Make flycheck-start-checker use `start-process' instead of `start-file-process'."
  (let ((orig (symbol-function 'start-file-process)))
    (fset 'start-file-process (symbol-function 'start-process))
    (unwind-protect (progn ad-do-it)
      (fset 'start-file-process orig))))

(require 'git-gutter)
(global-git-gutter-mode t)

(require 'git-commit)
(global-git-commit-mode t)

(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;
;; Includes
;;;;;;;;;;;;;;;;;;;;;;;;

;(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(add-to-list 'auto-mode-alist '("\\.ael$" . ael-mode))

(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.pl$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pm$" . cperl-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.sls$" . yaml-mode))

(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(global-hl-line-mode t)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(package-selected-packages
   (quote
    (rjsx-mode company tide yaml-mode php-mode highlight-parentheses git-gutter git-commit flycheck coffee-mode))))

;(put 'upcase-region 'disabled nil)

(require 'whitespace)
(setq whitespace-style '(face empty tabs trailing))
(global-whitespace-mode t)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(setq typescript-indent-level 2)
(setq tide-format-options
      '(:indentSize 2 :tabSize 4))



;;;;;;;;;;;;;;;;;;;;;;;;
;; Basics
;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-full-name "Arthur NGUYEN")
(setq user-mail-adress "arth.nguyen@gmail.com")
(setq clean-buffer-list-delay-general 1)

(setq-default
 inhibit-startup-message t
 global-font-lock-mode t
 show-trailing-whitespace t
 show-paren-mode t
 delete-selection-mode t
 column-number-mode t
 line-number-mode t
 frame-title-format "%b"
 tool-bar-mode nil
 menu-bar-mode nil
 scroll-bar-mode nil
 mouse-wheel-mode t
 comint-prompt-read-only t
 indent-tabs-mode nil
 )

(transient-mark-mode t)

(menu-bar-mode 0)


;;;;;;;;;;;;;;;;;;;;;;;;
;; Short cut
;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-c i") 'indent-region)
(global-set-key (kbd "C-c w") 'delete-trailing-whitespace)
(define-key global-map "\M-[1~" 'beginning-of-line)
(define-key global-map [select] 'end-of-line)
(global-set-key (kbd "C-c C-u") 'uncomment-region)

;(global-unset-key "C-x 0")
;(global-set-key (kbd "C-x 0") 'kill-buffer-and-window)
;(substitute-key-definition 'delete-window
;			   'kill-buffer-and-window
;			   global-map)

;; window
;(global-set-key (kbd "M-q")		'other-window)
;(global-set-key (kbd "ESC <down>")	'enlarge-window)
;(global-set-key (kbd "ESC <up>")  	'shrink-window)
;(global-set-key (kbd "ESC <left>")  	'shrink-window-horizontally)
;(global-set-key (kbd "ESC <right>") 	'enlarge-window-horizontally)

;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme
;;;;;;;;;;;;;;;;;;;;;;;;

(defun theme-hiten-256 ()

  (custom-set-faces

   '(default ((t (:foreground "#bbbbbb" :weight light))))
   '(cursor ((t (:background "red"))))
   '(font-lock-builtin-face ((t (:foreground "#78f2c9"))))
   '(font-lock-preprocessor-face ((t (:foreground "#e5786d"))))
   '(font-lock-comment-delimiter-face ((t (:foreground "#c0bc6c"))))
   '(font-lock-comment-face ((t (:foreground "gray42"))))
   '(font-lock-comment-delimiter-face ((t (:foreground "red"))))
   '(font-lock-constant-face ((t (:foreground "#e5786d"))))
   '(font-lock-function-name-face ((t (:foreground "#f1aa7e"))))
   '(font-lock-keyword-face ((t (:foreground "#87afff"))))
   '(font-lock-string-face ((t (:foreground "#95e454"))))
   '(font-lock-type-face ((t (:foreground"#caeb82"))))
   '(font-lock-variable-name-face ((t (:foreground "#f1ba7e"))))
   '(whitespace-tab ((t (:background "gray24"))))
   '(linum ((t (:foreground "gray42" :background "#111111"))))
   '(highlight ((t (:background "gray15" :height 1.0))))
   '(mode-line ((default (:foreground "#bbbbbb" :background "#0087d7"))))
   '(mode-line-inactive ((default (:foreground "#bbbbbb" :background "#444444"))))
   '(mouse ((t (:background "white"))))
   '(region ((t (:background "#253B76"))))
   '(vertical-border ((t (:foreground "black"))))
   '(minibuffer-prompt ((t (:foreground "#36b5b1"))))
   '(ac-completion-face ((t (:foreground "white" :underline t))))
   '(popup-isearch-match ((t (:background "sky blue" :foreground "red"))))
   '(ecb-default-highlight-face ((t (:background "gray42"))))
   '(flycheck-info ((t (:background "blue"))))
   '(flycheck-warning ((t (:background "yellow" :foreground "black"))))
   '(flycheck-error ((t (:background "red"))))
   )

)

(theme-hiten-256)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto-Complete Configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ??? 07/08/2014
;(ac-config-default)
;(set 'ac-disable-faces '(font-lock-string-face font-lock-doc-face))
;(set 'ac-auto-start t)

;;;;;;;;;;;;;;;;;;;;;;;;
;; Tramp
;;;;;;;;;;;;;;;;;;;;;;;;

;; Backup everything in temp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;(add-to-list 'load-path "~/tramp/lisp/")
(require 'tramp)
;(setq tramp-default-user "root")
(setq tramp-verbose 10)
(setq tramp-debug-buffer t)
(setq tramp-default-method "ssh")

(if (eq system-type 'cygwin)
    (progn
      (setq tramp-default-method "sshx")))
;      (setq tramp-default-method "ssh")))

; "\\(?:^\\|^M\\)[^]#$%>\n]*#?[]#$%>] *\\(^[\\[[0-9;]*[a-zA-Z] *\\)*"
;(setq tramp-shell-prompt-pattern "\\(?:^\\|\r\\)[^]#$%>\n]*#?[]#$%>]")
;\\(^[\\[[0-9;]*[a-zA-Z] *\\)*")

; For sudo on remote hosts
(setq tramp-default-proxies-alist
             `((nil "\\`root\\'" "/ssh:%h:")))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))

(setq tramp-backup-directory-alist backup-directory-alist)

;show host in mode line
(defconst my-mode-line-buffer-identification
  (list
   '(:eval
     (let ((host-name
	    (if (file-remote-p default-directory)
		(tramp-file-name-host
		 (tramp-dissect-file-name default-directory))
	      (system-name))))
       (if (string-match "^[^0-9][^.]*\\(\\..*\\)" host-name)
	   (substring host-name 0 (match-beginning 1))
	 host-name)))
   ": %12b"))
(setq-default
 mode-line-buffer-identification
 my-mode-line-buffer-identification)
(add-hook
 'dired-mode-hook
 '(lambda ()
    (setq
     mode-line-buffer-identification
     my-mode-line-buffer-identification)))

;;;;;;;;;;;;;;;;;;;;;;;;
;; Hooks              ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(defun font-lock-width-keyword (width)
  "Return a font-lock style keyword for a string beyond width WIDTH
   that uses 'font-lock-warning-face'."
  `((,(format "^%s\\(.+\\)" (make-string width ?.))
     ;(1 font-lock-warning-face t)
     (0 '(:foreground "red") t)
     (1 '(:background "red") t)
     )
    )
  )


; ??? 07/08/2014
;(font-lock-add-keywords 'python-mode (font-lock-width-keyword 80))
;(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

(add-hook 'c-mode-hook
	  '(lambda ()
	     (setq-default show-trailing-whitespace t)
	     (hs-minor-mode)
             (setq tab-width 4)
             (setq standard-indent 2)
             (setq c-basic-offset 2)
	     ;; (doxymacs-mode t)
             (doc-mode t)
	     )
	  )

(add-hook 'c++-mode-hook
	  '(lambda ()
	     (setq-default show-trailing-whitespace t)
	     (hs-minor-mode)
	     (c-set-style "bsd")
	     (setq-default indent-tabs-mode nil)
             (setq tab-width 4)
             (setq standard-indent 2)
             (setq c-basic-offset 2)
             (c-set-offset 'innamespace 0)
	     ;; (doxymacs-mode t)
             (doc-mode t)
	     )
	  )

(add-hook 'python-mode-hook
	  '(lambda ()
	     (setq-default show-trailing-whitespace t)
	     (define-key python-mode-map "\C-c\C-c" 'comment-region)
	     (setq whitespace-style '(face empty tabs lines-tail trailing))
	     (set-face-attribute 'whitespace-line nil :background "red" :foreground "white")
	     )
	  )

(add-hook 'cperl-mode-hook
	  '(lambda ()
             (hs-minor-mode)
	     (setq-default show-trailing-whitespace t)
	     (define-key cperl-mode-map "\C-c\C-c" 'comment-region)
	     )
	  )

(add-hook 'sh-mode-hook
	  '(lambda ()
	     (define-key sh-mode-map (kbd "C-c C-c") 'comment-region)
	     (define-key sh-mode-map (kbd "C-c C-q") 'indent-region)
             (setq indent-tabs-mode nil)
	     )
	  )

(add-hook 'sql-mode-hook
	  '(lambda ()
	     (define-key sql-mode-map (kbd "C-c C-a") 'sql-send-region)
	     (global-auto-complete-mode t)
	     (setq indent-tab-mode nil)
	     (setq-default show-trailing-whitespace nil)
	     )
	  )

(add-hook 'sql-interactive-mode-hook
	  '(lambda ()
             (auto-complete-mode t)
	     (setq-default show-trailing-whitespace nil)
	     )
	  )

(add-hook 'sgml-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode nil)
	     (setq sgml-basic-offset 2)
	     )
	  )

(add-hook 'php-mode-hook
	  '(lambda ()
             (hs-minor-mode)
             (setq tab-width 4)
             (setq standard-indent 2)
             (setq c-basic-offset 2)
	     (setq-default indent-tabs-mode nil)
             (c-set-offset 'substatement-open 0)
             ))

; EOF
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#bbbbbb" :weight light))))
 '(ac-completion-face ((t (:foreground "white" :underline t))))
 '(cursor ((t (:background "red"))))
 '(ecb-default-highlight-face ((t (:background "gray42"))))
 '(flycheck-error ((t (:background "red"))))
 '(flycheck-info ((t (:background "blue"))))
 '(flycheck-warning ((t (:background "yellow" :foreground "black"))))
 '(font-lock-builtin-face ((t (:foreground "#78f2c9"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#c0bc6c"))))
 '(font-lock-comment-face ((t (:foreground "gray42"))))
 '(font-lock-constant-face ((t (:foreground "#e5786d"))))
 '(font-lock-function-name-face ((t (:foreground "#f1aa7e"))))
 '(font-lock-keyword-face ((t (:foreground "#87afff"))))
 '(font-lock-preprocessor-face ((t (:foreground "#e5786d"))))
 '(font-lock-string-face ((t (:foreground "#95e454"))))
 '(font-lock-type-face ((t (:foreground "#caeb82"))))
 '(font-lock-variable-name-face ((t (:foreground "#f1ba7e"))))
 '(highlight ((t (:background "gray15" :height 1.0))))
 '(linum ((t (:foreground "gray42" :background "#111111"))))
 '(minibuffer-prompt ((t (:foreground "#36b5b1"))))
 '(mode-line ((default (:foreground "#bbbbbb" :background "#0087d7"))))
 '(mode-line-inactive ((default (:foreground "#bbbbbb" :background "#444444"))))
 '(mouse ((t (:background "white"))))
 '(popup-isearch-match ((t (:background "sky blue" :foreground "red"))))
 '(region ((t (:background "#253B76"))))
 '(vertical-border ((t (:foreground "black"))))
 '(whitespace-tab ((t (:background "gray24")))))
