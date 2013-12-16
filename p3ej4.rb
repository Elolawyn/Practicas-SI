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

if ARGV.count != 2 then raise ErrorEntrada_NumeroIncorrectoArgumentos, "El número de argumentos indicado es incorrecto." end

if ARGV[0] != "-f" then raise ErrorEntrada_ComandoDesconocido, "Se ha indicado un comando desconocido." end

if File.exists?(ARGV[1]) == false then raise ErrorEntrada_NoExisteFichero, "No existe el fichero indicado." end

if File.zero?(ARGV[1]) == true then raise ErrorEntrada_FicheroVacio, "El fichero indicado está vacío." end

datos = File.read(ARGV[1])
md5 = OpenSSL::Digest::MD5.new()
hash = md5.hexdigest(datos)

puts "###############################################"
puts "# Hash: " + hash
