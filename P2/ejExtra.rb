#!/usr/bin/env ruby
# encoding: utf-8

# Este es un ejercicio extra de encriptación/desencriptación Caesar con clave.
# Se emplea una clave para desordenar las letras del alfabeto.
#
# Para desordenarlo, se toma cada caracter único de la clave y se coloca en el
# alfabeto a partir de la posición de permutación. Esto es, si la clave es OLAOLA
# y la permutación es de 3, se ubicarían de la siguiente forma:
#
# 1 2 3 4 5 6 7 8 9 10 11 12 ....
#     O L A
#
# Después se colocan el resto de caracteres del alfabeot original en su orden a partir
# de A ignorando los 3 caracteres ya colocados (O L A) de esta forma:
#
# 1 2 3 4 5 6 7 8 9 10 11 12 ....
# Y Z O L A B C D E F  G  H  ....

require_relative 'caesar.rb'

class ErrorEntrada_NumeroIncorrectoArgumentos < StandardError
end

class ErrorEntrada_ComandoDesconocido < StandardError
end

password = ""
cadena = "Voy a cifrar esto: 487945 358 980 3274 546908 34587."

llamada_correcta = "\nEjemplo de llamada:\n ruby ejExtra.rb <mensaje> -p <clave>\n ruby ejExtra.rb <mensaje>\n ejExtra.rb"

if (ARGV.count == 1)
  cadena = ARGV[0]
elsif (ARGV.count == 3)
  if ARGV[1] != "-p" then raise ErrorEntrada_ComandoDesconocido, "\nNo existe el comando \"" + ARGV[2] + "\"." + llamada_correcta end
  password = ARGV[2]
  cadena = ARGV[0]
elsif (ARGV.count == 0)
else
  raise ErrorEntrada_NumeroIncorrectoArgumentos, "El número de argumentos indicado es incorrecto." + llamada_correcta 
end

c = CifradorCaesar.new(3, password)

puts "Cadena original: " + cadena

cadena = c.codificar(cadena)
cadena_enc = cadena

puts "Cadena codificada: " + cadena

cadena = c.decodificar(cadena)

puts "Cadena descodificada: " + cadena

puts "\nVamos a hacer una prueba de fuerza bruta como en el ej08.rb sin usar la clave\n(para esta prueba suponemos que conozco los caracteres usados, el alfabeto,\npero no se como estan ordenados, gracias a la clave): \n--------------------------------------"

for i in 1..85
  c_sinclave = CifradorCaesar.new(i)
  resultado = c_sinclave.decodificar(cadena_enc)
  puts "Iteración [" + i.to_s + "]: " + resultado
end

puts "\nComo vemos la clave, al desordenar el alfabeto aumenta un poco la seguridad aunque ya sabemos que no es seguro."
