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
(define-param sx 100) ; size of cell in um
(define-param sy 7) ; size of cell in Y direction in um
(set! geometry-lattice (make lattice (size sx sy no-size)))

;; make objects
(set! geometry (list
                ;; weak outter
                (make block (center 0 1.775 ) (size infinity 3 infinity)
                      (material (make dielectric (epsilon 9.0))))
                ;; nanosheet capacitor
                (make block (center 0 0.275 ) (size infinity 0.05 infinity)
                      (material (make dielectric (epsilon 4.0))))
                ;; waveguide 
                (make block (center -15 0.24 ) (size 70 0.02 infinity)
                      (material (make dielectric (epsilon 11.68))))
                ;; waveguide 
                (make block (center 30 0.24 ) (size 20 0.02 infinity)
                      (material (make dielectric (epsilon 11.60))))
                ;; waveguide 
                (make block (center 45 0.24 ) (size 10 0.02 infinity)
                      (material (make dielectric (epsilon 11.68))))
                ;; waveguide
                (make block (center 0 0 ) (size infinity 0.46 infinity)
                      (material (make dielectric (epsilon 11.68))))
                ;; waveguide 
                (make block (center -15 -0.24 ) (size 70 0.02 infinity)
                      (material (make dielectric (epsilon 11.68))))
                ;; waveguide 
                (make block (center 30 -0.24 ) (size 20 0.02 infinity)
                      (material (make dielectric (epsilon 11.60))))
                ;; waveguide 
                (make block (center 45 -0.24 ) (size 10 0.02 infinity)
                      (material (make dielectric (epsilon 11.68))))
                ;; weak inner conductor
                (make block (center 0 -1 ) (size infinity 1.5 infinity)
                      (material (make dielectric (epsilon 9.0))))
                ;; platinum
                (make block (center 0 -2.25 ) (size infinity 1 infinity)
                      (material myPt))
                ))

;; sources
(set! sources (list
               (make source
                 (src (make gaussian-src (wavelength 1.5) (width 5))) ;; make pulse width 100 femto seconds    
                 (component Ez)
                 (center (* (- (/ sx 2) 1) -1) 0 ) (size 0 0.5))))

(set! pml-layers (list (make pml (thickness 1.0))))
(set! resolution 50)

;; output 
(run-until 400
           (at-beginning output-epsilon)
           (to-appended "ez" (at-every 10 output-efield-z))
           (to-appended "box-30" (at-every 10 (in-volume (volume (center -30 0 0) (size 10 .5 0)) output-dpwr)))
           (to-appended "box0" (at-every 10 (in-volume (volume (center 0 0 0) (size 10 .5 0)) output-dpwr)))
           (to-appended "box30" (at-every 10 (in-volume (volume (center 30 0 0) (size 10 .5 0)) output-dpwr)))
           (at-every 30 (output-png Ez "-Zc bluered"))
           )

(display-fluxes x1)
(display-fluxes x2)
