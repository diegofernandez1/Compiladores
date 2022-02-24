#lang racket

;; 1. Escribe una función que al ingresar la edad en años de una persona determine cuántos
;; segundos, minutos y horas han pasado desde su nacimiento hasta el presente (o el momento en
;; que es invocada esta función).

(define (calculaEdad edad)
  (let* ([horas (calculaBisiestos 2022 edad 0)]
         [mins (* horas 60)]
         [segs (* mins 60)])
    (string-append "horas: " (~v horas) ", minutos: " (~v mins) ", segundos: " (~v segs))))

;; Utilizando recursión de cola recibe el año en el que es calculada la función, la edad y retorna las horas
;; tomando en cuenta años bisiestos
(define (calculaBisiestos anio edad acc)
  (cond
    [(= edad 0) acc]
    [else (if (= (modulo anio 4) 0)
              (calculaBisiestos (- anio 1) (- edad 1) (+ acc (* edad 366 24)))
              (calculaBisiestos (- anio 1) (- edad 1) (+ acc (* edad 365 24))))]))

;; 2. Escribe una función que tome una lista con al menos un elemento y un predicado como
;; argumento y elimine los elementos de la lista que no satisfagan el predicado.
(define (filtra l p)
  (cond
    [(empty? l) '()]
    [else
      (let ([c (car l)]) (if (p c)
                           (cons c (filtra p (cdr l)))
                           (filtra p (cdr l))))]))

;; 3. Escribe una definición para una estructura que sea una lista de números, llamada LON
;; (List Of Numbers).
(struct LON (numlist))

; any-even? : LON -> boolean
(define (any-even? lon)
  (let ([lista (LON-numlist lon)])
    (cond
      [(empty? lista) false]
      [(even? (car lista)) true]
      [else (any-even? (LON(cdr lista)))])
  ))

; total-length : LON -> number
(define (total-length lon)
  (let ([lista (LON-numlist lon)])
    (cond
      [(empty? lista) 0]
      [else (+ 1 (total-length (LON (cdr lista))))]))
  )

;; 4. Se define una estructura tree.
(define-struct leaf (value) #:transparent)

(define-struct node (value left right) #:transparent)

;prime-fac : number -> list
(define (prime-fac n)
  (letrec ([calcPrimes (λ (num d l) (cond
                                      [(= num 1) l]
                                      [(= (modulo num d) 0) (calcPrimes (/ num d) d (append l (list d)))]
                                      [else (calcPrimes num (+ 1 d) l)]))])
    (calcPrimes n 2 '())))

; div-tree : number -> tree
(define (div-tree n)
  (letrec ([build-tree (λ (t prime-list)
                         (if (= (length prime-list) 1)
                             (leaf t)
                             (node t (leaf (car prime-list)) (build-tree (/ t (car prime-list)) (cdr prime-list)))))])
    (build-tree n (prime-fac n))))

