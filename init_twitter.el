(add-to-list 'load-path "~/.emacs.d/twittering-mode")
;;
;; twittering-mode
;;
(eval-when-compile
  (require 'cl))

(require 'twittering-mode)
(setq twittering-proxy-use t)

(setq twittering-proxy-server "127.0.0.1"
             twittering-proxy-port 8118
             twittering-uri-regexp-to-proxy
             (car
              (assqref 'web
                       (assqref 'twitter twittering-service-method-table))))


;; (setq twittering-web-host "wdtwitter.appspot.com")
;; ;; (setq twittering-api-host "wdtwitter.appspot.com/api")
;; (setq twittering-api-search-host "wdtwitter.appspot.com/search")

;; (setq twittering-api-host "wdicc.com/xxxx/o/wd/SOSYKW")
;; (setq twittering-url-request-resolving-p nil)

;; twittering-mode

(setq twittering-accounts
      `((twitter (username "lijinhui235711")
                 ;; (password ,twitter-pass)
                 ;; (auth basic))
                 (auth oauth))
        (sina (username "lijinhui235711@gmail.com")
              (auth oauth))))

(setq twittering-enabled-services `(sina twitter)
      twittering-initial-timeline-spec-string
      `(":home@sina"
        ":replies@sina" ":mentions@sina"
        ":home@twitter"
        ":replies@twitter" ":direct_messages@twitter"
        ))

(setq twittering-oauth-use-ssl nil
      twittering-use-ssl nil)

(setq twittering-fill-column 60)

(setq xwl-twittering-padding-size 5)
(setq twittering-my-fill-column (- twittering-fill-column
                                   xwl-twittering-padding-size))

(set-face-background twittering-zebra-1-face "gray4")
(set-face-background twittering-zebra-2-face "gray4")

(set-face-foreground twittering-zebra-2-face "magenta")
(set-face-foreground twittering-zebra-1-face "deep sky blue")

;; (set-face-foreground twittering-uri-face "red")
;; (set-face-foreground twittering-username-face "red")


;; (setq twittering-status-format
;; (concat "%FACE[twittering-zebra-1-face,twittering-zebra-2-face]{%i %g %s, from %f%L%r%R:\n%FOLD["
;; (make-string xwl-twittering-padding-size ? ) "]{%t}"
;; ;; put image near center, 20 -- approximately width of image
;; "%FOLD[" (make-string (- (/ twittering-fill-column 2) 20) ? ) "]{%T}\n}")
;; twittering-my-status-format
;; "%FACE[twittering-zebra-1-face,twittering-zebra-2-face]{%g %s, from %f%L%r%R: %i\n%FOLD[]{%t%T}\n}")

(setq twittering-format-tweet-text-function
      'my-twittering-format-tweet-text-function)

(defun my-twittering-format-tweet-text-function (quoted-text text status)
  (if quoted-text
      (concat text "\n\n " (propertize
                              quoted-text
                              'face font-lock-function-name-face))
    text))

(setq twittering-status-format
      (concat "%i %g %s, from %f%L%r%R:\n%FOLD["
              (make-string xwl-twittering-padding-size ? ) "]{%t}"
              ;; put image near center, 20 -- approximately width of image
              "%FOLD["
              (make-string xwl-twittering-padding-size ? ) "]{%T}\n")
      twittering-my-status-format
      (concat "%g %s, from %f%L%r%R: %i\n%FOLD["
      (make-string xwl-twittering-padding-size ? ) "]{%t%T}\n"))


(setq twittering-retweet-format "RT @%s: %t")

(setq twittering-url-show-status nil
      twittering-notify-successful-http-get nil)

(setq twittering-new-tweets-count-excluding-me t
      twittering-new-tweets-count-excluding-replies-in-home t
      twittering-timer-interval 300
      twittering-cache-spec-strings
      '(":home@twitter"
        ":retweets_of_me@twitter" ":replies@twitter" ":direct_messages@twitter"

        ":home@sina"
        ":mentions@sina" ":replies@sina"
        )
      )

(setq twittering-update-status-function
      'twittering-update-status-from-pop-up-buffer)

(setq twittering-new-tweets-count-excluding-me t)

(setq twittering-convert-fix-size nil
      twittering-use-convert nil)

(twittering-enable-unread-status-notifier)
(setq-default twittering-icon-mode t)
(twittering-enable-unread-status-notifier)

;; (setq twittering-account-authorization '() )

(add-hook 'twittering-mode-hook
          (lambda()
            (goto-address-mode 1)
            (set-face-foreground twittering-uri-face "lemon chiffon")
            ))


(define-key twittering-mode-map (kbd "C")
      'twittering-erase-all)

(define-key twittering-mode-map (kbd "u")
      'twittering-switch-to-unread-timeline)


