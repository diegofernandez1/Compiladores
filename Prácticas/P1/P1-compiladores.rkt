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
;; 6 Punto extra

(define (is-perfect tree)
  (cond
    [(and (null? (node-left tree)) (null? (node-left tree))) true]
    [(and (not (null? (node-left tree))) (not(null? (node-left tree)))) (and (is-perfect (node-left tree)) (is-perfect (node-right tree)))]
    [(or (not (null? (node-left tree))) (not(null? (node-left tree)))) false]))

;; 5. Arboles leafy

; one-depth-tree : number ->  tree
(define (one-depth-tree type)
  (cond
    [(= type 0) (leaf "'leaf")]
    [(= type 1) (node null (leaf "'leaf") null)]
    [(= type 2) (node null  null (leaf "'leaf"))]
    [(= type 3) (node null  (leaf "'leaf") (leaf "'leaf"))]
    ))

(define (all-combinations depth)
  (cond
    [(= depth 0) '()]
    [(= depth 1) (list (one-depth-tree 0))]
    [(= depth 2) (list (one-depth-tree 0) (one-depth-tree 1) (one-depth-tree 2) (one-depth-tree 3))]
    [else (let ([tree1 (leaf "'leaf")]) (remove-duplicates(flatten(list (combinations  (tree1 tree1 depth) (all-combinations (- depth 1)))))))]))

(define (combinations original-tree tree n)
  (cond
    [(= n 0) '()]
    [(=(node-value tree) null) (cond
                                  [((null? (node-left tree)) (list (combinations original-tree (node-right tree (- n 1)))))]
                                  [((null? (node-right tree)) (list (combinations original-tree (node-left tree (- n 1)))))]
                                  [else (remove-duplicates (flatten '((combinations original-tree (node-right tree) (- n 1)) (combinations original-tree (node-left tree n-1)))))]
                                  )]
    [else (let () '())]
    ))