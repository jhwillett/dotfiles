;; JHW's .emacs file
;; Jesse H. Willett
;;
;; December  3, 2003
;; February 14, 2006
;; May      19, 2009
;; April    14, 2015

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
(put 'downcase-region 'disabled nil)
