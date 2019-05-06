;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname GridparimiterV4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;type in (main num row num col) and you will get a grid that size to simulate
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

(define (val-s ws)
  (first (rest (rest (rest (first ws))))))

(define (val-k ws)
  (first (first ws)))







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


(define (find-col x ws)
  (floor (/ x (val-s ws))))

(define (find-row y ws)
  (floor (/ y (val-s ws))))



(define (click  c mx my evnt)
  (if (string=? "button-down" evnt)
      (cons (first c) (change (find-col mx c) (find-row my c) (rest c)))
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


(define (colom col ws)
  (if (empty? col)
      (square 0 "solid" "Black")
      (beside (if (first col)
                  (square (val-s ws) "solid" "Black")
                  (square (val-s ws) "solid" "yellow"))
              (colom (rest col) ws))))



(define (draw c grid ws)
  (if (empty? c)
      (above (text (number->string (calc-parimiter grid grid 0)) 24 "black")
             (text (val-k ws) 24 "Black"))
      (above (colom (first c) ws)
             (draw (rest c) grid ws))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; center grid


(define (find-y grid ws)
  (/ (+ 54 (* (val-s ws) (val-y grid))) 2)
  )

(define (find-x grid ws)
  (/ (* (val-s ws) (val-x grid)) 2)
  )

(define (render c)
  (place-image (draw (rest c) (rest c) c) (find-x (rest c) c) (find-y (rest c) c) (empty-scene 1500 750)))


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

(define (up-press ws)
  [cond [(string=? (first (first ws)) "X") (creat-worldstate (+ (first (rest (first ws))) 1) (first (rest (rest (first ws)))) (first (rest (rest (rest (first ws))))) (first (first ws)))]
        [(string=? (first (first ws)) "Y") (creat-worldstate (first (rest (first ws))) (+ 1 (first (rest (rest (first ws))))) (first (rest (rest (rest (first ws))))) (first (first ws)))]
        [(string=? (first (first ws)) "S") (creat-worldstate (first (rest (first ws))) (first (rest (rest (first ws)))) (+ 1 (first (rest (rest (rest (first ws)))))) (first (first ws)))]
        [else ws]])

(define (down-press ws)
  [cond [(string=? (first (first ws)) "X") (creat-worldstate (- (first (rest (first ws))) 1) (first (rest (rest (first ws)))) (first (rest (rest (rest (first ws))))) (first (first ws)))]
        [(string=? (first (first ws)) "Y") (creat-worldstate (first (rest (first ws))) (- (first (rest (rest (first ws)))) 1) (first (rest (rest (rest (first ws))))) (first (first ws)))]
        [(string=? (first (first ws)) "S") (creat-worldstate (first (rest (first ws))) (first (rest (rest (first ws)))) (- (first (rest (rest (rest (first ws))))) 1) (first (first ws)))]
        [else ws]])

(define (key-handler c key)
  [cond [(key=? key "c") (cons (first c) (cover false (rest c)))]
        [(key=? key "b") (cons (first c) (cover true (rest c)))]
        [(key=? key "x") (cons (cons "X" (rest (first c))) (rest c))]
        [(key=? key "y") (cons (cons "Y" (rest (first c))) (rest c))]
        [(key=? key "s") (cons (cons "S" (rest (first c))) (rest c))]
        [(key=? key "up") (up-press c)]
        [(key=? key "down") (down-press c)]
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

(define (creat-params x y s k)
  (cons k (cons x (cons y (cons s empty)))))

(define (creat-worldstate x y s k)
  (cons (creat-params x y s k) (creat-grid x y)))


(define (initalize z)
  (running (creat-worldstate 10 10 30 "X"))
  )
(initalize 0)

