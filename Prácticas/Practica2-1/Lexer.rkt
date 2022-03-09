#lang nanopass

;; Bibliotecas chidas para lexear
(require parser-tools/lex
         parser-tools/lex-plt-v200
         (prefix-in : parser-tools/lex-sre);Operadores
         (prefix-in re- parser-tools/lex-sre)
         parser-tools/yacc)

(provide (all-defined-out));Exporta todos los identificadores que están definidos en el  nivel
;de fase relevante dentro del módulo de exportación, y que tienen el mismo contexto léxico

(define-tokens a (NUM VAR BOOL TYPE))
;; NUM = valores numéricos
;; Var = variables
;; Bool = Valores booleanos
;; Type = Para algún tipo

(define-empty-tokens b (LP RP LCB RCB LRB RRB : + - * / => = AND OR EOF IF THEN ELSE FUN FUNF LET IN END APP))
;; LP = left parenthesis
;; RP = right parenthesis
;; LCB = left curly brackets
;; RCB = right curly brackets
;; LRB = left rectangular brackets
;; RRB = right rectangular brackets
;; => = implies

; sre : S-regular expressions
(define calc-lexer
           (lexer
             ["#t"
              ; =>
              (token-BOOL (string->symbol lexeme))]

             ["#f"
              ; =>
              (token-BOOL (string->symbol lexeme))]
             
             ["and"
              ; =>
              (token-AND)]
             
             ["or"
              ; =>
              (token-OR)]

             ["if"
              ; =>
              (token-IF)]

             ["then"
              ; =>
              (token-THEN)]

             ["else"
              ; =>
              (token-ELSE)]

             ["fun"
              ; =>
              (token-FUN)]

             ["funF"
              ; =>
              (token-FUNF)]

             ["let"
              ; =>
              (token-LET)]

             ["in"
              ; =>
              (token-IN)]

             ["end"
              ; =>
              (token-END)]

             ["app"
              ; =>
              (token-APP)]

             [(:or "Bool" "Int" "Func")
              ; =>
              (token-TYPE (match-type lexeme))]
             
             [(:: (:+ (:or (char-range #\a #\z) (char-range #\A #\Z))) (:or (:* (char-range #\0 #\9)) (epsilon)) (:or (:+ (:or (char-range #\a #\z) (char-range #\A #\Z))) (epsilon))) ; (a-z | A-Z)^+(0-9)^*(a-z | A-Z)^
              ; =>
              (token-VAR (string->symbol lexeme))]

             [(::  (:or #\- (epsilon)) (:: (:* (char-range #\0 #\9)) (:: (:or (:: #\. (char-range #\0 #\9)) (:: (char-range #\0 #\9)) #\.) (:* (char-range #\0 #\9)))))
              ; =>
              (token-NUM (string->number lexeme))]

             ["=>"
              ; =>
              (token-=>)]

             [#\:
              ; =>
              (token-:)]

             [#\=
              ; =>
              (token-=)]

             [#\+
              ; =>
              (token-+)]

             [#\-
              ; =>
              (token--)]

             [#\*
              ; =>
              (token-*)]

             [#\/
              ; =>
              (token-/)]

             [#\(
              ; =>
              (token-LP)]

             [#\)
              ; =>
              (token-RP)]

             [#\{
              ; =>
              (token-LCB)]

             [#\}
              ; =>
              (token-RCB)]

             [#\[
              ; =>
              (token-LRB)]

             [#\]
              ; =>
              (token-RRB)]
             
             [whitespace
              ; =>
              (calc-lexer input-port)]

             [(eof)
              (token-EOF)]

             ))

;; Recibe una cadena string con el tipo y devuelve su símbolo correspondiente
(define (match-type n)
  (match n
    ["Int" 'Int]
    ["Bool" 'Bool]
    ["Func" 'Func]))

;;MinHS call, tal y como viene en el pdf de la práctica
(define (minHS-lexer s)
  (calc-lexer s))

(define-struct arith-exp (op e1 e2) #:transparent)
(define-struct num-exp (n) #:transparent)
(define-struct var-exp (i) #:transparent)

