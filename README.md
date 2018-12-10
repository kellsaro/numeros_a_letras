Esta es una gema que agrega a la clase Numeric el método a_letras,
que devuelve la expresión literal del número en idioma español.
Existe un el alias to_words, para las personas de habla hispana
que programan en inglés.
Ej: 

$ irb
>> require './lib/numeros_a_letras.rb'
>> 100.a_letras
=> "cien"
>> 98.a_letras
=> "noventa y ocho"
>> 100.a_letras
=> "cien"
>> 14673.a_letras
=> "catorce mil seiscientos setenta y tres"
>> 14646673.a_letras
=> "catorce millones seiscientos cuarenta y seis mil seiscientos setenta y tres"
>> 140000646673.a_letras
=> "ciento cuarenta mil millones seiscientos cuarenta y seis mil seiscientos setenta y tres"
>> 3894749.a_letras
=> "tres millones ochocientos noventa y cuatro mil setecientos cuarenta y nueve"
>> 389474900000.a_letras
=> "trescientos ochenta y nueve mil cuatrocientos setenta y cuatro millones novecientos mil"
>> -389474900000.a_letras
=> "menos trescientos ochenta y nueve mil cuatrocientos setenta y cuatro millones novecientos mil"
>> -38947490.a_letras
=> "menos treinta y ocho millones novecientos cuarenta y siete mil cuatrocientos noventa"

Fue realizado con Ruby 1.8.\*, aunque debe funcionar en versiones posteriores

TODO
* Hay que hacer casos de prueba
* Se debe poder optimizar el algoritmo
* incluir un parámetro del método que sea el lenguaje
y en dependencia del mismo es la respuesta. Habría que 
desarrollar los algoritmos para los diferentes idiomas.
Ej: 100.a_letras(:es)  => "cien", 100.to_words(:en) => "one hundred"

