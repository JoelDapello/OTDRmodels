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
(define-param sx 1500) ; size of cell in um
(define-param sy 6) ; size of cell in Y direction in um
(set! geometry-lattice (make lattice (size sx sy no-size)))

;; make objects
(set! geometry (list
                ;; weak outter
                (make block (center 0 1.775 ) (size infinity 3 infinity)
                      (material (make dielectric (epsilon 9))))
                ;; nanosheet capacitor
                (make block (center 0 0.275 ) (size infinity 0.05 infinity)
                      (material (make dielectric (epsilon 4))))
                ;; waveguide 
                (make block (center 0 0 ) (size infinity 0.5 infinity)
                      (material (make dielectric (epsilon 11.68))))
                ;; weak inner conductor
                (make block (center 0 -1.00 ) (size infinity 1.5 infinity)
                      (material (make dielectric (epsilon 9.0))))
                ;; platinum
                (make block (center 0 -2.25 ) (size infinity 1 infinity)
                      ;; (material (make dielectric (epsilon 3.0))))
                      (material myPt))
                ))

;; sources
(set! sources (list
               (make source
                 (src (make gaussian-src (wavelength 1.5) (width 5))) ;; make pulse width 100 femto seconds    
                 (component Ez)
                 (center (* (- (/ sx 2) 1) -1) 0 ) (size 0 0.5))))

(set! pml-layers (list (make pml (thickness 0.1))))
(set! resolution 50)

(define x-500 ; reflected flux                                                   
  (add-flux 0.66 0.5 100
            (make flux-region 
              (center -500 0) (size 0 1))))

(define x-200 ; reflected flux                                                   
  (add-flux 0.66 0.5 100
            (make flux-region 
              (center -200 0) (size 0 1))))

(define x-50 ; reflected flux                                                   
  (add-flux 0.66 0.5 100
            (make flux-region 
              (center -50 0) (size 0 1))))

(define x50 ; reflected flux                                                   
  (add-flux 0.66 0.5 100
            (make flux-region 
              (center 50 0) (size 0 1))))

(define x200 ; reflected flux                                                   
  (add-flux 0.66 0.5 100
            (make flux-region 
              (center 200 0) (size 0 1))))

(define x500 ; reflected flux                                                   
  (add-flux 0.66 0.5 100
            (make flux-region 
              (center 500 0) (size 0 1))))

;; output 
(run-until 5625
           (at-beginning output-epsilon)
	   (to-appended "ez" (at-every 20 output-efield-z))
           (at-every 20 (output-png Ez "-Zc bluered"))
           )

(display-fluxes x-500)
(display-fluxes x-200)
(display-fluxes x-50)
(display-fluxes x50)
(display-fluxes x200)
(display-fluxes x500)
