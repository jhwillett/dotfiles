;; JHW's .emacs file
;; Jesse H. Willett
;;
;; December  3, 2003
;; February 14, 2006
;; May      19, 2009
;; April    14, 2015
;; January  20, 2018

;; Emacs packages requires Emacs 24.1 or higher.
;;
;; Fortunately, as of 2021-11-02, both Emacs for Mac OSX and Homebrew emacs are
;; at 27.2, so we no longer need to check (when (version>= ...)), etc.
;;
;; We enable MELPA, the widely-used ELPA repo in which we find go-mode and many
;; other fun packages.
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;;
;; Install (from MELPA) packages of interest which are not already installed.
;;
(defun package-install-if-not-installed (package)
  (or (package-installed-p package)
      (package-install package)
      ))
;;(package-install-if-not-installed 'markdown-mode)
;;(package-install-if-not-installed 'nginx-mode)
;;(package-install-if-not-installed 'enh-ruby-mode)
;;(package-install-if-not-installed 'gnugo)
;;(mapc
;; (lambda (package)
;;   (or (package-installed-p package)
;;      (package-install package)))
;; '(markdown-mode nginx-mode enh-ruby-mode))

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;; Configure Emacs as a Go Editor From Scratch
;;
;;   https://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/
;;   https://tleyden.github.io/blog/2014/05/27/configure-emacs-as-a-go-editor-from-scratch-part-2/
;;
;;(mapc
;; (lambda (package)
;;   (or (package-installed-p package)
;;       (package-install package)))
;; '(go-mode exec-path-from-shell)) ;; install packages if not already installed

(add-to-list 'exec-path "/Users/jhw/go/bin/")
(add-to-list 'exec-path "/opt/homebrew/bin/")
(add-hook 'before-save-hook 'gofmt-before-save)

;; TODO(jhw): godef-jump is a cool function, bind it to a hot key!?

;;(add-hook 'go-mode-hook
;;          (lambda ()
;;            (add-hook 'before-save-hook 'gofmt-before-save)
;;            (setq tab-width 2)
;;            (setq indent-tabs-mode 1)
;;            ))

;;(setq gofmt-command "goimports")
;;(add-hook 'go-mode-hook (lambda () (add-hook 'before-save-hook 'gofmt-before-save)))

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))
(when window-system (set-exec-path-from-shell-PATH))

(setenv "GOPATH" "/Users/tleyden/Development/gocode")
(getenv "PATH")
(getenv "GOPATH")

(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
)
(add-hook 'go-mode-hook 'my-go-mode-hook)


;;; Visual line mode totally breaks the logical structure of the file,
;;; and really jacks me up when I'm doing ad-hoc editing macros. Worse
;;; feature, ever! :(
;;;
;;; Since Emacs 23 they did this dumb thing where long lines navigate
;;; like two lines.
;;;
;;; This makes it so CTRL-N and CTRL-F and friends move by 1 logical
;;; line - not by 1 line as it's displayed on the terminal.
;;;
;;; Without this, recording macros with like:
;;;
;;;  CTRL-X SHIFT-( macro CTRL-X SHIFT-) CTRL-U CTRL-X CTRL-E
;;;
;;; and so forth can really suck - they behave unpredictably in the
;;; presence of other dev's code.
;;;
(setq line-move-visual nil)

;;;; Cause emacs to prompt on exit: I don't like this feature, but
;;;; sometimes I activate it to be sure .emacs is loading.

;;(setq kill-emacs-query-functions
;;      (cons (lambda () (yes-or-no-p "Really kill Emacs? "))
;;    kill-emacs-query-functions))

;;;; Stuff from:
;;;;   http://www.dotemacs.de/dotfiles/IngoKoch/IngoKoch.emacs-gnu-all.html

;; Set F1 to be a short cut for goto-line
;;
(global-set-key [f1] 'goto-line)
(global-set-key "\C-j" 'goto-line)

;; ---------------------------------------------------------------------------
;; Beside the row I'd also like to see the column in the mode line
;; ---------------------------------------------------------------------------
(setq column-number-mode t)

;; ---------------------------------------------------------------------------
;; To get emacs a bit more consistent, replace all yes or no questions with
;; simple y or n.
;; ---------------------------------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p)

;; ---------------------------------------------------------------------------
;; Give me colors, please.
;; But give me the colors I prefer!
;; ---------------------------------------------------------------------------
(require 'font-lock)
(global-font-lock-mode t)

;; Big fonts please!
;;
;; 200 is 20pt font
;;
(set-face-attribute 'default nil :height 260)

;; Skip the splash screen
;;
(setq inhibit-splash-screen t)

;; Don't intermix tabs and spaces in the indentations (interoperates
;; poorly with MS.NET):
(setq-default indent-tabs-mode nil)
;; JHW: remember M-x untabify, for when you're frusterated by tabs!

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max) nil)
  )
(global-set-key [f8] 'indent-buffer)

;; php-mode, from:
;;
;;  http://php-mode.sourceforge.net/php-mode.html#Installation
;;
(add-to-list 'load-path "~/.elisp/php-mode-1.5.0")
(load "php-mode")
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'" . php-mode))

;; Use bash-mode for Procfiles.
;;
;; There is foreman-mode in MELPA but I had trouble getting it to install, and
;; it seems to want to execute Procfiles, not focus on editing them.
;;
(add-to-list 'auto-mode-alist '("\\.procfile" . shell-mode))
(add-to-list 'auto-mode-alist '("Procfile"    . shell-mode))


;; actionscript-mode, from:
;;
;;  http://php-mode.sourceforge.net/php-mode.html#Installation
;;
(load-file "~/.elisp/actionscript-mode.el")
(autoload 'actionscript-mode "javascript" nil t)
(add-to-list 'auto-mode-alist '("\\.as\\'" . actionscript-mode))
(put 'upcase-region 'disabled nil)

;; yaml-mode, from:
;;
;;  https://github.com/yoshiki/yaml-mode
;;
(load-file "~/.elisp/yaml-mode/yaml-mode.el")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; Enhanced Ruby Mode, from:
;;
;;   https://github.com/zenspider/enhanced-ruby-mode
;;
;(add-to-list 'load-path "~/.elisp/enhanced-ruby-mode")
;(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
;(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
;(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; optional

;;;(setq enh-ruby-program "(path-to-ruby1.9)/bin/ruby") ; so that still works if ruby points to ruby1.8
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(setq ruby-insert-encoding-magic-comment nil)

;; Nice, sane window sizes, thanks to:
;;
;;   http://stackoverflow.com/questions/92971
;;
;;(if (window-system)
;;   (set-frame-height (selected-frame) 40))
;;345678901234567890123456789012345678901234567890123456789012345678901234567890
;;
;; I like an editor which is on the top-right of the screen, under
;; which I can see some lines from my interactive shell.
;;
(setq default-frame-alist '((left . -1) (width . 81) (height . 22)))
(setq-default fill-column 80)

;(add-to-list 'load-path "~/.elisp")
;(require 'column-marker)
;(column-marker-1 80)
;(add-hook 'foo-mode-hook (lambda () (interactive) (column-marker-1 80)))
;(require 'fill-column-indicator)
;(setq fci-rule-column 17)
;(setq fci-rule-width 3)
;(setq fci-rule-color "darkblue")

;; Specify Postgres-mode for .psql and .plsql files, and also for .sql files
;; because in my env they are almost certainly PG SQL files.
;;
(load-file "~/.elisp/plsql.el")
(add-to-list 'auto-mode-alist
             '("\\.psql$"  . (lambda ()
                              (plsql-mode)
                              (sql-highlight-postgres-keywords))))
(add-to-list 'auto-mode-alist
             '("\\.plsql$" . (lambda ()
                              (plsql-mode)
                              (sql-highlight-postgres-keywords))))
(add-to-list 'auto-mode-alist
             '("\\.sql$"   . (lambda ()
                              (plsql-mode)
                              (sql-highlight-postgres-keywords))))

;; https://www.emacswiki.org/emacs/BackupDirectory
;;
;; Don't litter working directories with foo~.
(setq
 backup-by-copying t                    ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs.d/saves"))          ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)                     ; use versioned backups

(add-to-list 'auto-mode-alist '("Dockerfile.*" . makefile-mode))
(add-to-list 'auto-mode-alist '("Procfile.*" . makefile-mode))

;; BATS is in Bash
;;
(add-to-list 'auto-mode-alist '("\\.bats$" . shell-script-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rust-mode exec-path-from-shell nginx-mode foreman-mode procfile-mode markdown-mode enh-ruby-mode gnugo go-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; Finding non-ASCII characters.
;;;
;;; https://www.emacswiki.org/emacs/FindingNonAsciiCharacters
;;;
(defun occur-non-ascii ()
  "Find any non-ascii characters in the current buffer."
  (interactive)
  (occur "[^[:ascii:]]"))

;; protobuf mode, per `brew install protobuf` which delivers:
;;
;;   /opt/homebrew/share/emacs/site-lisp/protobuf/protobuf-mode.el
;;
(add-to-list 'load-path "/opt/homebrew/share/emacs/site-lisp/protobuf")
;;(load "protobuf-mode")
;;(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))


;; rust-mode and friends
;;
;; https://github.com/rust-lang/rust-mode?tab=readme-ov-file#melpa
;;
;; This worked after:
;;
;;   M-x package-install rust-mode
;;
(require 'rust-mode)
