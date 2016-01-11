;; JHW's .emacs file
;; Jesse H. Willett
;;
;; December  3, 2003
;; February 14, 2006
;; May      19, 2009

;;;; Cause emacs to prompt on exit: I don't like this feature, but
;;;; sometimes I activate it to be sure .emacs is loading.

;;(setq kill-emacs-query-functions
;;      (cons (lambda () (yes-or-no-p "Really kill Emacs? "))
;;    kill-emacs-query-functions))

;;;; Stuff from:
;;;;   http://www.dotemacs.de/dotfiles/IngoKoch/IngoKoch.emacs-gnu-all.html

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

;; as much colours as possible for c and c++
(setq font-lock-maximum-decoration
      '((c-mode    . 5)
        (c++-mode  . 5)
        (java-mode . 5)
        (t         . 5))
      )

(setq-default default-tab-width 3)
(setq c-default-style "bsd")
(setq-default c-basic-offset 3)
(setq-default c-indent-tabs-mode nil)
(setq-default c++-indent-tabs-mode nil)
(setq-default java-indent-tabs-mode nil)
(setq-default python-indent-tabs-mode nil)
;;(custom-set-faces)

;; Don't intermix tabs and spaces in the indentations (interoperates
;; poorly with MS.NET):
(setq-default indent-tabs-mode nil)
;; JHW: remember M-x untabify, for when you're frusterated by tabs!

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max) nil)
  )
(global-set-key [f8] 'indent-buffer)

;; The following came from http://www.emacswiki.org/cgi-bin/wiki/PythonMode:
;(add-to-list 'load-path "d:/cygwin/home/jhw/.elisp")
;(add-to-list 'load-path "d:/cygwin/home/jhw/.elisp/python-mode-1.0")
;(autoload 'python-mode "python-mode" "Python Mode." t)
;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;(add-to-list 'auto-mode-alist '("\\Sconstruct\\'" . python-mode))
;(add-to-list 'auto-mode-alist '("\\SConstruct\\'" . python-mode))
;(add-to-list 'auto-mode-alist '("\\sconstruct\\'" . python-mode))
;(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;(add-hook 'python-mode-hook
;          (lambda ()
;            (set (make-variable-buffer-local 'beginning-of-defun-function)
;                 'py-beginning-of-def-or-class)
;            (setq outline-regexp "def\\|class ")))

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

;; Big fonts please, I'm dying here.
;;
(set-face-attribute 'default nil :height 240)
