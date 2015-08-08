;; set grid (2d)
(define-param sx 200) ; size of cell in um
(define-param sy 6) ; size of cell in Y direction in um
(set! geometry-lattice (make lattice (size sx sy no-size)))

;; 1276.25,
;; 1225,
;; 1218.75,
;; 968.75,
;; -276.25,
;; -1301.25 ]


;; make objects
(set! geometry (list
                ;; nanosheet capacitor
                (make block (center 0 1.625 ) (size infinity 2.75 infinity)
                      (material (make dielectric (epsilon 1.0))))
                ;; waveguide w/ alternating free carrier injection
                (make block (center 0 0 ) (size infinity 0.5 infinity)
                      (material (make dielectric (epsilon 11.68))))
                ;; weak inner conductor
                (make block (center 0 -1.625 ) (size infinity 2.75 infinity)
                      (material (make dielectric (epsilon 9.0))))
                ))

;; sources
(set! sources (list
               (make source
                 (src (make gaussian-src (wavelength 1.5) (width 5))) ;; make pulse width 100 femto seconds    
                 (component Ez)
                 (center (* (- (/ sx 2) 1) -1) 0 ) (size 0 0.5))))

(set! pml-layers (list (make pml (thickness 0.1))))
(set! resolution 30)

(define refl ; reflected flux                                                   
  (add-flux 0.66 0.5 100
            (make flux-region 
              (center -3 0) (size 0 1))))

;; output 
(run-until 300
           (at-beginning output-epsilon)
           (at-every 30 (output-png Ez "-Zc bluered"))
           )

(display-fluxes refl)

;; y range:1.75 through -1.75 y total 3.5

;; 1.5,
;; 1.245,
;; 0.995,
;; -0.25,
;; -1.5 
