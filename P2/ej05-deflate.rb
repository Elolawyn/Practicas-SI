#!/usr/bin/env ruby
# encoding: utf-8

require 'zlib'

class ErrorEntrada_NumeroIncorrectoArgumentos < StandardError
end

class ErrorEntrada_ComandoDesconocido < StandardError
end

class ErrorEntrada_NoExisteFichero < StandardError
end

class ErrorEntrada_FicheroVacio < StandardError
end

llamada_correcta = "\nEjemplo de llamada: ruby ej04-deflate.rb <fichero_a_descomprimir> -o <salida>"

if ARGV.count != 3 then raise ErrorEntrada_NumeroIncorrectoArgumentos, "\nEl número de argumentos indicado es incorrecto." + llamada_correcta end

if ARGV[1] != "-o" then raise ErrorEntrada_ComandoDesconocido, "\nNo existe el comando \"" + ARGV[1] + "\"." + llamada_correcta end

if File.exists?(ARGV[0]) == false then raise ErrorEntrada_NoExisteFichero, "\nNo existe el fichero \"" + ARGV[0] + "\""+ llamada_correcta end

if File.zero?(ARGV[0]) == true then raise ErrorEntrada_FicheroVacio, "\nEl fichero \"" + ARGV[0] + "\" está vacío. " + llamada_correcta end

texto_a_descomprimir = ""

File.open(ARGV[0], 'r') do |f|
	while linea = f.gets
		texto_a_descomprimir << linea
	end
end

puts "Tamaño del fichero a descomprimir: " + texto_a_descomprimir.size.to_s

texto_a_descomprimir = Zlib::Inflate.inflate(texto_a_descomprimir)

puts "Tamaño del fichero descomprimido: " + texto_a_descomprimir.size.to_s

File.open(ARGV[2], 'w') do |f|
	f << texto_a_descomprimir
end
