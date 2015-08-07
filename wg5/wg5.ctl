;; recursive list maker
(define (makelist n)                ; make list 1 - 9
  (if (= n 1)
     (list 0)                       ; base case. Just return (0)
     (cons n (makelist (- n 1)))))  ; recursive case. Add n to the head of (n-1 n-2 ... 0)

;; make align list onto grid
(define (segment xl)
  (map (lambda (v) (- (* v 20) (/ xl 2)))
       (makelist xl)))              ; (- (- v (/ x 2))) offset)

;; create alternating list of n1 and n2 to length xl
(define (alternaten n1 n2 xl)
  (map (lambda (v) (if (odd? v) n1 n2))
       (makelist xl)))



(define myPt (make dielectric (epsilon 1)
                   (polarizations
                    (make polarizability
                      (omega 1e-20) (gamma 0.064524) (sigma 1.9923e+41))
                    (make polarizability
                      (omega 0.62911) (gamma 0.41699) (sigma 28.872))
                    (make polarizability
                      (omega 1.0598) (gamma 1.4824) (sigma 35.102))
                    (make polarizability
                      (omega 2.5334) (gamma 2.9584) (sigma 5.099))
                    (make polarizability
                      (omega 7.4598) (gamma 6.8694) (sigma 3.8445))
                    )))



;; set grid (2d)
(define-param sx 800) ; size of cell in um
(define-param sy 3.5) ; size of cell in Y direction in um
(set! geometry-lattice (make lattice (size sx sy no-size)))

;; 1276.25,
;; 1225,
;; 1218.75,
;; 968.75,
;; -276.25,
;; -1301.25 ]


;; make objects
(set! geometry (append
                (list
                 ;; nanosheet capacitor
                 (make block (center 0 1.5 ) (size infinity 0.5 infinity)
                       (material (make dielectric (epsilon 100.00) (mu (/ 1 100)))))
                 ;; silicon waveguide w/o free carrier injection
                 (make block (center 0 0.995 ) (size infinity 0.49 infinity)
                       (material (make dielectric (epsilon 11.68))))
                 ;; weak inner conductor
                 (make block (center 0 -0.25 ) (size infinity 2 infinity)
                       (material (make dielectric (epsilon 9.0))))
                 ;; ground make platinum 
                 (make block (center 0 -1.5 ) (size infinity 0.5 infinity)
                       (material metal)))
                ;; (material (make dielectric (epsilon 3.68)))))
                 ;; 2nd list, dynamic materials created by map
                 ;; waveguide w/ alternating free carrier injection
                 (map                    
                  (lambda (cx e)         ;; input params: cx center of x position, e epsilon
                    (make block (center cx 1.245 ) (size 20 0.01 infinity) ;; block
                          (material (make dielectric (epsilon e)))))   ;; material of block
                  (segment sx)             ;; cx list
                  (alternaten 11.68 11.6 sx))))  ;; e list      -> alternaten
      
(set! pml-layers (list (make pml (thickness 0.1))))
(set! resolution 30)

;; sources
(set! sources (list
               (make source
                 (src (make gaussian-src (wavelength 1.5) (width 9.5))) ;; make pulse width 100 femto seconds    
                 (component Ez)
                 (center (* (- (/ sx 2) 1) -1) 1 ) (size 0 0.5))))


;; output 
(run-until 3000
           (at-beginning output-epsilon)
           (at-every 30 (output-png Ez "-Zc bluered")))


;; y range:1.75 through -1.75 y total 3.5

;; 1.5,
;; 1.245,
;; 0.995,
;; -0.25,
;; -1.5 
