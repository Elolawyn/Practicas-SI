#!/usr/bin/env ruby
# encoding: utf-8

require 'openssl'

class ErrorEntrada_NumeroIncorrectoArgumentos < StandardError
end

class ErrorEntrada_ComandoDesconocido < StandardError
end

class ErrorEntrada_NoExisteFichero < StandardError
end

class ErrorEntrada_FicheroVacio < StandardError
end

system 'clear'

#Llamadas al programa
#0 1 2 3 4 5
#-f fichero -h hash -a algoritmo 6
#-f fichero -h hash 4
#-c fichero fichero -a algoritmo 5
#-c fichero fichero 3
#-f fichero -a algoritmo 4
#-f fichero 2

if ARGV.count != 4 then raise ErrorEntrada_NumeroIncorrectoArgumentos, "El número de argumentos indicado es incorrecto." end

if ARGV[0] != "-f" then raise ErrorEntrada_ComandoDesconocido, "Se ha indicado un comando desconocido." end

if File.exists?(ARGV[1]) == false then raise ErrorEntrada_NoExisteFichero, "No existe el fichero indicado." end

if File.zero?(ARGV[1]) == true then raise ErrorEntrada_FicheroVacio, "El fichero indicado está vacío." end
  
if ARGV[2] != "-h" then raise ErrorEntrada_ComandoDesconocido, "Se ha indicado un comando desconocido." end
  
datos = File.read(ARGV[1])
md5 = OpenSSL::Digest::MD5.new()
hash = md5.hexdigest(datos)

hash_entrada = ARGV[3]

puts "MD5 de '" + ARGV[1] + "': " + hash
puts "MD5 de entrada: " + hash_entrada

if (hash == hash_entrada) then puts "El hash indicado es igual al del fichero" else puts "El hash indicado es distinto al del fichero" end