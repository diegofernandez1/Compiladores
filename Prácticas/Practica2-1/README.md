# Práctica 2.1

### Integrantes:

1. Romo Olea Fhernanda Montserrat - 314284286
2. Rodrigo Alvar Reyna Trejo - 312196785
3. Diego Marcial Fenrández Del Valle - 314198039

### Descripción

Se completa el código del archivo **Lexer.rkt** para retornar el token equivalente a la primera coincidencias de una cadena recibida, sea una cadena completa o la cadena a medias, el lexer puede reconocer los tokens y devolverlos según sea el caso. 

Para probar su funcionalidad se puede introducir la llamada a función **minHS-lexer** tal y como viene en el pdf de la práctica, ya que esta función fue implementada como parte de la práctica.

- (minHS-lexer (open-input-string "3 - 3.3 + 6")) (token ’NUM 3)
- (minHS-lexer (open-input-string "182 * 23")) (token ’NUM 182)
- (minHS-lexer (open-input-string "(182 * 23)")) ’LP