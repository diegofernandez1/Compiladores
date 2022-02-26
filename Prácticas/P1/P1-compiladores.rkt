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


;; 5. Arboles Leafy

;; Método que devuelve la lista con las combinaciones de los árboles leafy completos de a lo más n de profundidad
; combinations : number -> list
(define (combinations n)
  (cond
    [(= n 0) (leaf "'leaf")]
    [else (flatten(list (all-leafy-full n) (combinations (- n 1))))]))

;; Auxilar para crear los árboles Leafy llenos

; c : number ->  tree
(define (all-leafy-full n)
  (cond
    [(= n 0) (leaf "'leaf")]
    [(= n 1) (node null  (leaf "'leaf") (leaf "'leaf"))]
    [else (node null (all-leafy-full (- n 1)) (all-leafy-full (- n 1)))]))

;; 6 Punto extra

;; Auxiliar que calcula la profundidad de un árbol por la izquierda
; tree-depth-left : tree -> number
(define (tree-depth-left tree)
  (if (leaf? tree) 
      0
      (+ 1 (tree-depth-left (node-left tree)))))


;;Método que organiza la llamada al método recursivo
; is-perfect : tree -> boolean
(define (is-perfect tree )
  (is-perfect-rec tree 0 (tree-depth-left tree)))

;;Método recursivo que verifica si un árbol es perfecto o no
; is-perfect-rec : tree number number -> boolean
(define (is-perfect-rec tree level depth)
  (cond
    [(leaf? tree) (equal? depth level )]
    [(or (null? (node-left tree)) (null? (node-right tree))) false]
    [else (and (is-perfect-rec (node-left tree) (+ level 1) depth) (is-perfect-rec (node-right tree) (+ level 1) depth))]))


