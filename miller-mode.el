;;; miller-mode.el --- major mode for editing the miller dsl -*- coding: utf-8; lexical-binding: t; -*-

;; Copyright © 2022, by William Blackerby

;; Author: William Blackerby (wmblackerby@gmail.com)
;; Version: 0.0.1
;; Created: 20 Nov 2022
;; Keywords: languages, text processing
;; Homepage: https://github.com/blackerby/miller-mode.el

;; This file is not part of GNU Emacs.

;;; License:

;; You can redistribute this program and/or modify it under the terms of the GNU General Public License version 2.

;;; Commentary:


;;; Code:

;; create the list for font-lock
;; each category of keyword is given a particular face
(setq mlr-font-lock-keywords
      (let* (
	     (x-keywords '("begin" "do" "elif" "else" "end" "filter" "for" "if" "in" "while" "break" "continue" "return"
			   "func" "subr" "call" "dump" "edump"
			   "ENV" "IPS" "IFS" "IRS" "OPS" "OFS" "ORS" "OFLATSEP" "NF" "NR" "FNR" "FILENAME" "FILENUM"))
	     (x-builtins '("emit" "emitp" "emitf" "eprint" "eprintn" "print" "printn" "tee" "stdout" "stderr" "unset" "null"))
	     (x-types '("arr" "bool" "float" "int" "map" "num" "str" "var"))
	     (x-constants '("M_PI" "M_E" "true" "false"))
	     (x-operators '("!" "%" "&" "*" "+" "-" "." "/" ":" "<" ">" "?" "^" "|" "~" "!=" "&&" "**" ".*" ".+" ".-" "./" "//" "<<" "<="
			    "==" "=~" ">=" ">>" "??" "^^" "||" "!=~" ".//" ">>>" "???" "%=" "&=" "*=" "+=" "-=" ".=" "/=" "^=" "|=" "&&="
			    "**=" "//=" "<<=" ">>=" "??=" "^^=" "||=" ">>>=" "???="))

	     (x-keywords-regexp (regexp-opt x-keywords 'words))
	     (x-builtins-regexp (regexp-opt x-builtins 'words))
	     (x-types-regexp (regexp-opt x-types 'words))
	     (x-constants-regexp (regexp-opt x-constants 'words))
	     (x-operators-regexp (regexp-opt x-operators 'words)))

	`(
	  ("\\<\\$[a-zA-Z_][a-zA-Z_0-9]*\\>" . 'font-lock-doc-markup-face)
	  (,x-builtins-regexp . 'font-lock-preprocessor-face)
	  (,x-types-regexp . 'font-lock-type-face)
	  (,x-constants-regexp . 'font-lock-constant-face)
	  (,x-operators-regexp . 'font-lock-constant-face)
	  (,x-keywords-regexp . 'font-lock-keyword-face)
	  ("\\$\\*" . 'font-lock-doc-markup-mode)
	  ("\\<@[a-zA-Z_][a-zA-Z_0-9]*\\>" . 'font-lock-doc-markup-face)
	  ("\\(\\<[a-zA-Z_][a-zA-Z_0-9]*\\>\\)[ \t]*(" 1 'font-lock-function-name-face)
	  ("\\(\\<[a-zA-Z_][a-zA-Z_0-9]*\\>\\)" . 'font-lock-variable-name-face)
	  )))

(defvar mlr-mode-syntax-table nil "Syntax table for `miller-mode'.")

(setq mlr-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?# "<" st)
    (modify-syntax-entry ?\n ">" st)
    st))

;;;###autoload
(define-derived-mode miller-mode c-mode "Miller"
  "Major mode for editing the Miller DSL"

  (setq font-lock-defaults '((mlr-font-lock-keywords)))
  (set-syntax-table mlr-mode-syntax-table))
  
 (provide 'miller-mode)

;;; miller-mode.el ends here
