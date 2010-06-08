;----------cedet----
(print "cedet")
(add-to-list 'load-path  "~/.emacs.d/cedet/common")
(add-to-list 'load-path  "~/.emacs.d/cedet")

;(load-file (concat myeldir "cedet/common/cedet.el"))
(require 'cedet)


(semantic-stickyfunc-mode -1)
(global-semantic-stickyfunc-mode -1)


;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
(semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languges only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)


(print "end of cedet")
;;----------------end of cedet--------------





;;------------------ECB--------------
(print "ecb")
(add-to-list 'load-path "~/.emacs.d/ecb")
(require 'ecb)
(global-set-key [f12] 'ecb-activate) ;;定义F12键为激活ecb
(global-set-key [C-f12] 'ecb-deactivate) ;;定义Ctrl+F12为停止ecb

;(require 'ecb-autoloads)



(setq ;;ecb-use-speedbar-instead-native-tree-buffer 'source
      ;;ecb-layout-name "left6"
      ;ecb-primary-secondary-mouse-buttons 'mouse-1--C-mouse-1
      ecb-windows-width 0.25
      ecb-tip-of-the-day nil
)

;鼠标点击事件
(setq ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))

(setq ecb-layout-name "leftright-analyse")


(global-set-key (kbd "C-c g m") 'ecb-goto-window-methods) ;;切换到函数窗口
(global-set-key (kbd "C-c g a") 'ecb-goto-window-analyse)
(global-set-key (kbd "C-c g c") 'ecb-goto-window-compilation)
(global-set-key (kbd "C-c g d") 'ecb-goto-window-directories)
(global-set-key (kbd "C-c g e") 'ecb-goto-window-edit-last)
(global-set-key (kbd "C-c g h") 'ecb-goto-window-history)
(global-set-key (kbd "C-c g s") 'ecb-goto-window-symboldef)
(global-set-key (kbd "C-c g p") 'ecb-goto-window-speedbar)
(global-set-key (kbd "C-c h b") 'ecb-add-all-buffers-to-history)

(global-set-key (kbd "C-c s m") 'semantic-ia-fast-jump)

(global-semantic-stickyfunc-mode -1)

;(ecb-activate)
(print "end of ecb")
;;--------end of ecb---------

(setq cedet-graphviz-dot-command "C:/Program Files/Graphviz2.24/bin/dot.exe")

