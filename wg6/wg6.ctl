;; set grid (2d)
(define-param sx 800) ; size of cell in um
(define-param sy 3.5) ; size of cell in Y direction in um
(set! geometry-lattice (make lattice (size sx sy no-size)))

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

;; make objects
(set! geometry (list
                ;; nanosheet capacitor
                (make block (center 0 1.5 ) (size infinity 0.5 infinity)
                      (material (make dielectric (epsilon 100.00) (mu (/ 1 100)))))
                ;; waveguide w/ alternating free carrier injection
                (make block (center -195 1.245 ) (size 390 0.01 infinity) ;; block
                      (material (make dielectric (epsilon 11.68))))   ;; material of block
                ;; waveguide w/ alternating free carrier injection
                (make block (center 0 1.245 ) (size 20 0.01 infinity) ;; block
                      (material (make dielectric (epsilon 1))))   ;; material of block
                ;; waveguide w/ alternating free carrier injection
                (make block (center 195 1.245 ) (size 390 0.01 infinity) ;; block
                      (material (make dielectric (epsilon 11.68))))   ;; material of block
                ;; silicon waveguide w/o free carrier injection
                (make block (center 0 0.995 ) (size infinity 0.49 infinity)
                      (material (make dielectric (epsilon 11.68))))
                ;; weak inner conductor
                (make block (center 0 -0.25 ) (size infinity 2 infinity)
                      (material (make dielectric (epsilon 9.0))))
                ;; ground make platinum 
                (make block (center 0 -1.5 ) (size infinity 0.5 infinity)
                      (material myPt))
                ))

;; sources
(set! sources (list
               (make source
                 (src (make gaussian-src (wavelength 1.5) (width 5))) ;; make pulse width 100 femto seconds    
                 (component Ez)
                 (center (* (- (/ sx 2) 1) -1) 1 ) (size 0 0.5))))

(set! pml-layers (list (make pml (thickness 0.1))))
(set! resolution 60)

;; output 
(run-until 1000
           (at-beginning output-epsilon)
           (at-every 30 (output-png Ez "-Zc bluered"))
           )


;; y range:1.75 through -1.75 y total 3.5

;; 1.5,
;; 1.245,
;; 0.995,
;; -0.25,
;; -1.5 
