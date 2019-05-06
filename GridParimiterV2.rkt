;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname GridParimiterV2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   youu can click on the boxes in a set sized grid and it will give you the surface area   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (sa st)
  (+ (if (string=? (substring st 1 2) "b") (+ 2 (if (string=? (substring st 2 3) "b") 0 1) (if (string=? (substring st 9 10) "b") 0 1)) 0)
     (if (string=? (substring st 2 3) "b") (+ 1 (if (string=? (substring st 3 4) "b") 0 1) (if (string=? (substring st 10 11) "b") 0 1) (if (string=? (substring st 1 2) "b") 0 1)) 0)
     (if (string=? (substring st 3 4) "b") (+ 1 (if (string=? (substring st 4 5) "b") 0 1) (if (string=? (substring st 11 12) "b") 0 1) (if (string=? (substring st 2 3) "b") 0 1)) 0)
     (if (string=? (substring st 4 5) "b") (+ 1 (if (string=? (substring st 5 6) "b") 0 1) (if (string=? (substring st 12 13) "b") 0 1) (if (string=? (substring st 3 4) "b") 0 1)) 0)
     (if (string=? (substring st 5 6) "b") (+ 1 (if (string=? (substring st 6 7) "b") 0 1) (if (string=? (substring st 13 14) "b") 0 1) (if (string=? (substring st 4 5) "b") 0 1)) 0)
     (if (string=? (substring st 6 7) "b") (+ 1 (if (string=? (substring st 7 8) "b") 0 1) (if (string=? (substring st 14 15) "b") 0 1) (if (string=? (substring st 5 6) "b") 0 1)) 0)
     (if (string=? (substring st 7 8) "b") (+ 2 (if (string=? (substring st 15 16) "b") 0 1) (if (string=? (substring st 6 7) "b") 0 1)) 0)
     (if (string=? (substring st 9 10) "b") (+ 1 (if (string=? (substring st 1 2) "b") 0 1) (if (string=? (substring st 17 18) "b") 0 1) (if (string=? (substring st 10 11) "b") 0 1)) 0)
     (if (string=? (substring st 17 18) "b") (+ 1 (if (string=? (substring st 9 10) "b") 0 1) (if (string=? (substring st 25 26) "b") 0 1) (if (string=? (substring st 18 19) "b") 0 1)) 0)
     (if (string=? (substring st 25 26) "b") (+ 1 (if (string=? (substring st 17 18) "b") 0 1) (if (string=? (substring st 33 34) "b") 0 1) (if (string=? (substring st 26 27) "b") 0 1)) 0)
     (if (string=? (substring st 33 34) "b") (+ 1 (if (string=? (substring st 25 26) "b") 0 1) (if (string=? (substring st 41 42) "b") 0 1) (if (string=? (substring st 34 35) "b") 0 1)) 0)
     (if (string=? (substring st 41 42) "b") (+ 1 (if (string=? (substring st 33 34) "b") 0 1) (if (string=? (substring st 49 50) "b") 0 1) (if (string=? (substring st 42 43) "b") 0 1)) 0)
     (if (string=? (substring st 49 50) "b") (+ 2 (if (string=? (substring st 41 42) "b") 0 1) (if (string=? (substring st 50 51) "b") 0 1)) 0)
     (if (string=? (substring st 50 51) "b") (+ 1 (if (string=? (substring st 42 43) "b") 0 1) (if (string=? (substring st 51 52) "b") 0 1) (if (string=? (substring st 49 50) "b") 0 1)) 0)
     (if (string=? (substring st 51 52) "b") (+ 1 (if (string=? (substring st 43 44) "b") 0 1) (if (string=? (substring st 52 53) "b") 0 1) (if (string=? (substring st 50 51) "b") 0 1)) 0)
     (if (string=? (substring st 52 53) "b") (+ 1 (if (string=? (substring st 44 45) "b") 0 1) (if (string=? (substring st 53 54) "b") 0 1) (if (string=? (substring st 51 52) "b") 0 1)) 0)
     (if (string=? (substring st 53 54) "b") (+ 1 (if (string=? (substring st 45 46) "b") 0 1) (if (string=? (substring st 54 55) "b") 0 1) (if (string=? (substring st 52 53) "b") 0 1)) 0)
     (if (string=? (substring st 54 55) "b") (+ 1 (if (string=? (substring st 46 47) "b") 0 1) (if (string=? (substring st 55 56) "b") 0 1) (if (string=? (substring st 53 54) "b") 0 1)) 0)
     (if (string=? (substring st 55 56) "b") (+ 2 (if (string=? (substring st 47 48) "b") 0 1) (if (string=? (substring st 54 55) "b") 0 1) ) 0)
     (if (string=? (substring st 47 48) "b") (+ 1 (if (string=? (substring st 39 40) "b") 0 1) (if (string=? (substring st 55 56) "b") 0 1) (if (string=? (substring st 46 47) "b") 0 1)) 0)
     (if (string=? (substring st 39 40) "b") (+ 1 (if (string=? (substring st 31 32) "b") 0 1) (if (string=? (substring st 47 48) "b") 0 1) (if (string=? (substring st 38 39) "b") 0 1)) 0)
     (if (string=? (substring st 31 32) "b") (+ 1 (if (string=? (substring st 23 24) "b") 0 1) (if (string=? (substring st 39 40) "b") 0 1) (if (string=? (substring st 30 31) "b") 0 1)) 0)
     (if (string=? (substring st 23 24) "b") (+ 1 (if (string=? (substring st 15 16) "b") 0 1) (if (string=? (substring st 31 32) "b") 0 1) (if (string=? (substring st 22 23) "b") 0 1)) 0)
     (if (string=? (substring st 15 16) "b") (+ 1 (if (string=? (substring st 7 8) "b") 0 1) (if (string=? (substring st 23 24) "b") 0 1) (if (string=? (substring st 14 15) "b") 0 1)) 0)
     
     (if (string=? (substring st 10 11) "b") (+ (if (string=? (substring st 9 10) "b") 0 1) (if (string=? (substring st 11 12) "b") 0 1) (if (string=? (substring st 2 3) "b") 0 1) (if (string=? (substring st 18 19) "b") 0 1)) 0)
     (if (string=? (substring st 11 12) "b") (+ (if (string=? (substring st 10 11) "b") 0 1) (if (string=? (substring st 12 13) "b") 0 1) (if (string=? (substring st 3 4) "b") 0 1) (if (string=? (substring st 19 20) "b") 0 1)) 0)
     (if (string=? (substring st 12 13) "b") (+ (if (string=? (substring st 11 12) "b") 0 1) (if (string=? (substring st 13 14) "b") 0 1) (if (string=? (substring st 4 5) "b") 0 1) (if (string=? (substring st 20 21) "b") 0 1)) 0)
     (if (string=? (substring st 13 14) "b") (+ (if (string=? (substring st 12 13) "b") 0 1) (if (string=? (substring st 14 15) "b") 0 1) (if (string=? (substring st 5 6) "b") 0 1) (if (string=? (substring st 21 22) "b") 0 1)) 0)
     (if (string=? (substring st 14 15) "b") (+ (if (string=? (substring st 13 14) "b") 0 1) (if (string=? (substring st 15 16) "b") 0 1) (if (string=? (substring st 6 7) "b") 0 1) (if (string=? (substring st 22 23) "b") 0 1)) 0)
     
     (if (string=? (substring st 18 19) "b") (+ (if (string=? (substring st 17 18) "b") 0 1) (if (string=? (substring st 19 20) "b") 0 1) (if (string=? (substring st 10 11) "b") 0 1) (if (string=? (substring st 26 27) "b") 0 1)) 0)
     (if (string=? (substring st 19 20) "b") (+ (if (string=? (substring st 18 19) "b") 0 1) (if (string=? (substring st 20 21) "b") 0 1) (if (string=? (substring st 11 12) "b") 0 1) (if (string=? (substring st 27 28) "b") 0 1)) 0)
     (if (string=? (substring st 20 21) "b") (+ (if (string=? (substring st 19 20) "b") 0 1) (if (string=? (substring st 21 22) "b") 0 1) (if (string=? (substring st 12 13) "b") 0 1) (if (string=? (substring st 28 29) "b") 0 1)) 0)
     (if (string=? (substring st 21 22) "b") (+ (if (string=? (substring st 20 21) "b") 0 1) (if (string=? (substring st 22 23) "b") 0 1) (if (string=? (substring st 13 14) "b") 0 1) (if (string=? (substring st 29 30) "b") 0 1)) 0)
     (if (string=? (substring st 22 23) "b") (+ (if (string=? (substring st 21 22) "b") 0 1) (if (string=? (substring st 23 24) "b") 0 1) (if (string=? (substring st 14 15) "b") 0 1) (if (string=? (substring st 30 31) "b") 0 1)) 0)

     (if (string=? (substring st 26 27) "b") (+ (if (string=? (substring st 25 26) "b") 0 1) (if (string=? (substring st 27 28) "b") 0 1) (if (string=? (substring st 18 19) "b") 0 1) (if (string=? (substring st 34 35) "b") 0 1)) 0)
     (if (string=? (substring st 27 28) "b") (+ (if (string=? (substring st 26 27) "b") 0 1) (if (string=? (substring st 28 29) "b") 0 1) (if (string=? (substring st 19 20) "b") 0 1) (if (string=? (substring st 35 36) "b") 0 1)) 0)
     (if (string=? (substring st 28 29) "b") (+ (if (string=? (substring st 27 28) "b") 0 1) (if (string=? (substring st 29 30) "b") 0 1) (if (string=? (substring st 20 21) "b") 0 1) (if (string=? (substring st 36 37) "b") 0 1)) 0)
     (if (string=? (substring st 29 30) "b") (+ (if (string=? (substring st 28 29) "b") 0 1) (if (string=? (substring st 30 31) "b") 0 1) (if (string=? (substring st 21 22) "b") 0 1) (if (string=? (substring st 37 38) "b") 0 1)) 0)
     (if (string=? (substring st 30 31) "b") (+ (if (string=? (substring st 29 30) "b") 0 1) (if (string=? (substring st 31 32) "b") 0 1) (if (string=? (substring st 22 23) "b") 0 1) (if (string=? (substring st 38 39) "b") 0 1)) 0)

     (if (string=? (substring st 34 35) "b") (+ (if (string=? (substring st 33 34) "b") 0 1) (if (string=? (substring st 35 36) "b") 0 1) (if (string=? (substring st 26 27) "b") 0 1) (if (string=? (substring st 42 43) "b") 0 1)) 0)
     (if (string=? (substring st 35 36) "b") (+ (if (string=? (substring st 34 35) "b") 0 1) (if (string=? (substring st 36 37) "b") 0 1) (if (string=? (substring st 27 28) "b") 0 1) (if (string=? (substring st 43 44) "b") 0 1)) 0)
     (if (string=? (substring st 36 37) "b") (+ (if (string=? (substring st 35 36) "b") 0 1) (if (string=? (substring st 37 38) "b") 0 1) (if (string=? (substring st 28 29) "b") 0 1) (if (string=? (substring st 44 45) "b") 0 1)) 0)
     (if (string=? (substring st 37 38) "b") (+ (if (string=? (substring st 36 37) "b") 0 1) (if (string=? (substring st 38 39) "b") 0 1) (if (string=? (substring st 29 30) "b") 0 1) (if (string=? (substring st 45 46) "b") 0 1)) 0)
     (if (string=? (substring st 38 39) "b") (+ (if (string=? (substring st 37 38) "b") 0 1) (if (string=? (substring st 39 40) "b") 0 1) (if (string=? (substring st 30 31) "b") 0 1) (if (string=? (substring st 46 47) "b") 0 1)) 0)

     (if (string=? (substring st 42 43) "b") (+ (if (string=? (substring st 41 42) "b") 0 1) (if (string=? (substring st 43 44) "b") 0 1) (if (string=? (substring st 34 35) "b") 0 1) (if (string=? (substring st 50 51) "b") 0 1)) 0)
     (if (string=? (substring st 43 44) "b") (+ (if (string=? (substring st 42 43) "b") 0 1) (if (string=? (substring st 44 45) "b") 0 1) (if (string=? (substring st 35 36) "b") 0 1) (if (string=? (substring st 51 52) "b") 0 1)) 0)
     (if (string=? (substring st 44 45) "b") (+ (if (string=? (substring st 43 44) "b") 0 1) (if (string=? (substring st 45 46) "b") 0 1) (if (string=? (substring st 36 37) "b") 0 1) (if (string=? (substring st 52 53) "b") 0 1)) 0)
     (if (string=? (substring st 45 46) "b") (+ (if (string=? (substring st 44 45) "b") 0 1) (if (string=? (substring st 46 47) "b") 0 1) (if (string=? (substring st 37 38) "b") 0 1) (if (string=? (substring st 53 54) "b") 0 1)) 0)
     (if (string=? (substring st 46 47) "b") (+ (if (string=? (substring st 45 46) "b") 0 1) (if (string=? (substring st 47 48) "b") 0 1) (if (string=? (substring st 38 39) "b") 0 1) (if (string=? (substring st 54 55) "b") 0 1)) 0)
     ))


(define (colom str)
  (beside
   (if (string=? (substring str 0 1) "b") (square 30 "solid" "Black") (square 30 "solid" "yellow"))
   (if (string=? (substring str 1 2) "b") (square 30 "solid" "Black") (square 30 "solid" "yellow"))
   (if (string=? (substring str 2 3) "b") (square 30 "solid" "Black") (square 30 "solid" "yellow"))
   (if (string=? (substring str 3 4) "b") (square 30 "solid" "Black") (square 30 "solid" "yellow"))
   (if (string=? (substring str 4 5) "b") (square 30 "solid" "Black") (square 30 "solid" "yellow"))
   (if (string=? (substring str 5 6) "b") (square 30 "solid" "Black") (square 30 "solid" "yellow"))
   (if (string=? (substring str 6 7) "b") (square 30 "solid" "Black") (square 30 "solid" "yellow"))
   )
  )


(define (draw str)
  (above (colom (substring str 1 8))
         (colom (substring str 9 16))
         (colom (substring str 17 24))
         (colom (substring str 25 32))
         (colom (substring str 33 40))
         (colom (substring str 41 48))
         (colom (substring str 49 56))
         (text (number->string (sa str)) 24 "black")
         )

  )











(define MTS (empty-scene 400 400))  ;; creats the window


(define (main c)
  (big-bang c
    (to-draw render) ;; draws
    (on-mouse click)
    (on-key key-handler)
    ))


(define (key-handler c key)  ; key is "the key pressed" ie for space " " for a "a"
  [cond [(key=? key "c") "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"]
        [(key=? key "b") "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"]
        [else c]
        ]
  )

(define (render c)
  (place-image (draw c) 105 120 MTS)
  )

(define (click c mx my evnt)
  (if (and (mouse=? evnt "button-down") (> mx 0) (> my 0) (< mx 210) (< my 210))
      (change-str mx my c)
      c
      ))

(define (change-str x y c)
  (string-append (substring c 0 (ans x y)) (if (string=? "b" (substring c (ans x y) (+ (ans x y) 1))) "w" "b") (substring c (+ 1 (ans x y)))))


(define (ans x y)
  (+ 1 (col x) (* 8 (row y))))

(define (col x)
  (floor (/ x 30)))

(define (row y)
  (floor (/ y 30)))


(main "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww")
  