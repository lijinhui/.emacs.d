;;; protobuf-mode.el --- major mode for editing protocol buffers.

;; Author: Alexandre Vassalotti <alexandre@peadrop.com>
;; Created: 23-Apr-2009
;; Version: 0.1
;; Keywords: google protobuf languages

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Installation:
;;   - Put `protobuf-mode.el' in your Emacs load-path.
;;   - Add this line to your .emacs file:
;;       (require 'protobuf-mode)
;;
;; You can customize this mode just like any mode derived from CC Mode.  If
;; you want to add customizations specific to protobuf-mode, you can use the
;; `protobuf-mode-hook'. For example, the following would make protocol-mode
;; use 2-space indentation:
;;
;;   (defconst my-protobuf-style
;;     '((c-basic-offset . 2)
;;       (indent-tabs-mode . nil)))
;;   (defun my-set-protobuf-style ()
;;     (interactive)
;;     (c-add-style "my-style" my-protobuf-style t))
;;   (add-hook 'protobuf-mode-hook 'my-set-protobuf-style)
;;
;; Refer to the documentation of CC Mode for more information about
;; customization details and how to use this mode.
;;

;;; Code:

(require 'cc-mode)

(eval-when-compile
  (require 'cc-langs)
  (require 'cc-fonts))

;; This mode does not inherit properties from other modes. So, we do not use 
;; the usual `c-add-language' function.
(put 'protobuf-mode 'c-mode-prefix "protobuf-")

;; The following code uses of the `c-lang-defconst' macro define syntactic
;; features of protocol buffer language.  Refer to the documentation in the
;; cc-langs.el file for information about the meaning of the -kwds variables.

(c-lang-defconst c-primitive-type-kwds
  protobuf '("double" "float" "int32" "int64" "uint32" "uint64" "sint32"
             "sint32" "fixed32" "fixed64" "sfixed32" "sfixed64" "bool"
             "string" "bytes" "group"))

(c-lang-defconst c-type-prefix-kwds
  protobuf '("required" "optional" "repeated"))

(c-lang-defconst c-class-decl-kwds
  protobuf '("message" "enum" "service"))

(c-lang-defconst c-constant-kwds
  protobuf '("true" "false"))

(c-lang-defconst c-other-decl-kwds
  protobuf '("package" "import"))

(c-lang-defconst c-other-kwds
  protobuf '("default" "max"))

;; The following keywords do not fit well in keyword classes defined by
;; cc-mode.  So, we approximate as best we can.

(c-lang-defconst c-paren-type-kwds
  protobuf '("option" "returns"))

(c-lang-defconst c-type-list-kwds
  protobuf '("extensions" "to"))

(c-lang-defconst c-typeless-decl-kwds
  protobuf '("extend" "rpc"))

;; Here we remove default syntax for loops, if-statements and other C
;; syntactic features that are not supported by the protocol buffer language.

(c-lang-defconst c-block-stmt-1-kwds
  protobuf nil)

(c-lang-defconst c-block-stmt-2-kwds
  protobuf nil)

(c-lang-defconst c-simple-stmt-kwds
  protobuf nil)

(c-lang-defconst c-paren-stmt-kwds
  protobuf nil)

(c-lang-defconst c-label-kwds
  protobuf nil)

(c-lang-defconst c-before-label-kwds
  protobuf nil)

(c-lang-defconst c-cpp-matchers
  protobuf nil)


;; Add support for variable levels of syntax highlighting.

(defconst protobuf-font-lock-keywords-1 (c-lang-const c-matchers-1 protobuf)
  "Minimal highlighting for protobuf-mode.")

(defconst protobuf-font-lock-keywords-2 (c-lang-const c-matchers-2 protobuf)
  "Fast normal highlighting for protobuf-mode.")

(defconst protobuf-font-lock-keywords-3 (c-lang-const c-matchers-3 protobuf)
  "Accurate normal highlighting for protobuf-mode.")

(defvar protobuf-font-lock-keywords protobuf-font-lock-keywords-3
  "Default expressions to highlight in protobuf-mode.")

;; Our syntax table is auto-generated from the keyword classes we defined
;; previously with the `c-lang-const' macro.
(defvar protobuf-mode-syntax-table nil
  "Syntax table used in protobuf-mode buffers.")
(or protobuf-mode-syntax-table
    (setq protobuf-mode-syntax-table
          (funcall (c-lang-const c-make-mode-syntax-table protobuf))))

(defvar protobuf-mode-abbrev-table nil
  "Abbreviation table used in protobuf-mode buffers.")

(defvar protobuf-mode-map nil
  "Keymap used in protobuf-mode buffers.")
(or protobuf-mode-map
    (setq protobuf-mode-map (c-make-inherited-keymap)))

(easy-menu-define protobuf-menu protobuf-mode-map
  "Protocol Buffers Mode Commands"
  (cons "Protocol Buffers" (c-lang-const c-mode-menu protobuf)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

;;;###autoload
(defun protobuf-mode ()
  "Major mode for editing Protocol Buffers description language.

The hook `c-mode-common-hook' is run with no args at mode
initialization, then `protobuf-mode-hook'.

Key bindings:
\\{protobuf-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table protobuf-mode-syntax-table)
  (setq major-mode 'protobuf-mode
        mode-name "Protocol-Buffers"
        local-abbrev-table protobuf-mode-abbrev-table
        abbrev-mode t)
  (use-local-map protobuf-mode-map)
  (c-initialize-cc-mode t)
  (c-init-language-vars protobuf-mode)
  (c-common-init 'protobuf-mode)
  (easy-menu-add protobuf-menu)
  (c-run-mode-hooks 'c-mode-common-hook 'protobuf-mode-hook)
  (c-update-modeline))

(provide 'protobuf-mode)

;;; protobuf-mode.el ends here
