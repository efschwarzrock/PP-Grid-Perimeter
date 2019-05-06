;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname GridparimiterV3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;tyoe in (main num row num col) and you will get a grid that size to simulate
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (val-x-calc row)
  (if (empty? row)
      0
      (+ 1 (val-x-calc (rest row)))))

(define (val-x grid)
  (val-x-calc (first grid)))

(define (val-y grid)
  (if (empty? grid)
      0
      (+ 1 (val-y (rest grid)))))







(define (get-col y count col)
  (if (empty? col)
      false
      (if (= y count)
          (first col)
          (get-col y (+ count 1) (rest col))   )))



(define (get-vale x y count grid)
  (if (empty? grid)
      false
      (if (= x count)
          (get-col y 0 (first grid))
          (get-vale x y (+ count 1) (rest grid)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; mouse controles

(define (change-index in)
  (if in
      false
      true))


(define (change-colom col line count)
  (if (empty? line)
      
      empty
      
      (cons (if (= col count)
                (change-index (first line))
                (first line))
            (change-colom col (rest line) (+ 1 count))
            )))


(define (change-row col row grid count)
  (if (empty? grid)
      
      empty
      
      (cons (if (= row count)
                (change-colom col (first grid) 0)
                (first grid))
            (change-row col row (rest grid) (+ 1 count))
            )))



(define (change col row c)
  (if (and (<= col (val-x c)) (<= row (val-y c)))
  (change-row col row c 0)
  c))


(define (find-col x)
  (floor (/ x 30)))

(define (find-row y)
  (floor (/ y 30)))



(define (click  c mx my evnt)
  (if (string=? "button-down" evnt)
      (change (find-col mx) (find-row my) c)
      c))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;calculate parimiter




(define (add grid x y)
  (if (get-vale x y 0 grid)
      0
      1))


(define (calc-col row grid R Co)
  (if (empty? row)
      0
      (if (first row)
          (+ (add grid (- R 1) Co) (add grid (+ R 1) Co) (add grid R (+ Co 1)) (add grid R (- Co 1)) (calc-col (rest row) grid R (+ Co 1)))
          (calc-col (rest row) grid R (+ Co 1)))))




(define (calc-parimiter grid consgrid R)
  (if (empty? grid)
      0
      (+ (calc-col (first grid) consgrid R 0) (calc-parimiter (rest grid) consgrid (+ 1 R)))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;draw grid


(define (colom col)
  (if (empty? col)
      (square 0 "solid" "Black")
      (beside (if (first col)
                  (square 30 "solid" "Black")
                  (square 30 "solid" "yellow"))
              (colom (rest col)))))



(define (draw c grid)
  (if (empty? c)
      (text (number->string (calc-parimiter grid grid 0)) 24 "black")
      (above (colom (first c))
             (draw (rest c) grid))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; center grid


(define (find-y grid)
  (/ (+ 24 (* 30 (val-y grid))) 2)
  )

(define (find-x grid)
  (/ (* 30 (val-x grid)) 2)
  )

(define (render c)
  (place-image (draw c c) (find-x c) (find-y c) (empty-scene (+ 50 (* (val-x c) 30)) (+ 50 (* (val-y c) 30)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; key comands





(define (cover-col bool col)
  (if (empty? col)
      empty
      (cons bool (cover-col bool (rest col)))))





(define (cover bool grid)
  (if (empty? grid)
      empty
      (cons (cover-col bool (first grid)) (cover bool (rest grid)))))




(define (key-handler c key)
  [cond [(key=? key "c") (cover false c)]
        [(key=? key "b") (cover true c)]
        [else c]
        ])





(define (running c)
  (big-bang c
    (to-draw render) ;; draws
    (on-mouse click)
    (on-key key-handler)
    ))


(define (creat-col y)
  (if (= y 0)
      empty
      (cons false (creat-col (- y 1)))))



(define (creat-grid x y)
  (if (= x 0)
      empty
      (cons (creat-col y) (creat-grid (- x 1) y))))




(define (main y x)
  (running (creat-grid x y))
  )

