;; JHW's .emacs file
;; Jesse H. Willett
;;
;; December  3, 2003
;; February 14, 2006
;; May      19, 2009
;; April    14, 2015
;; January  20, 2018

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;
;; Packages require Emacs version 24.1 or higher but unfortunately,
;; MacOS has ancient 22.1.1 at '/usr/bin/emacs --version'.
;;
(if (not (version< emacs-version "24.1"))
    (progn
     (package-initialize)
     ;;
     ;; Enable Melpa, which is the ELPA email in which we find go-mode.
     ;;
     (require 'package)
     (add-to-list 'package-archives
                  '("melpa" . "http://melpa.milkbox.net/packages/") t)
     (setq tab-width 2)
     (add-hook 'go-mode-hook
               (lambda ()
                 (add-hook 'before-save-hook 'gofmt-before-save)
                 (setq tab-width 2)
                 (setq indent-tabs-mode 1))))
  )

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
 '(package-selected-packages (quote (go-mode))))
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
