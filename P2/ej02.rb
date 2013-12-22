#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'caesar.rb'

class ErrorEntrada_NumeroIncorrectoArgumentos < StandardError
end

class ErrorEntrada_ComandoDesconocido < StandardError
end

class ErrorEntrada_NoExisteFichero < StandardError
end

class ErrorEntrada_FicheroVacio < StandardError
end

c = CifradorCaesar.new(3)

llamada_correcta = "\nEjemplo de llamada: ruby ej02.rb <fichero_a_desencriptar> -o <salida>"

if ARGV.count != 3 then raise ErrorEntrada_NumeroIncorrectoArgumentos, "\nEl número de argumentos indicado es incorrecto." + llamada_correcta end

if ARGV[1] != "-o" then raise ErrorEntrada_ComandoDesconocido, "\nNo existe el comando \"" + ARGV[1] + "\"." + llamada_correcta end

if File.exists?(ARGV[0]) == false then raise ErrorEntrada_NoExisteFichero, "\nNo existe el fichero \"" + ARGV[0] + "\""+ llamada_correcta end

if File.zero?(ARGV[0]) == true then raise ErrorEntrada_FicheroVacio, "\nEl fichero \"" + ARGV[0] + "\" está vacío. " + llamada_correcta end

texto_a_descifrar = ""

File.open(ARGV[0], 'r') do |f|
	while linea = f.gets
		texto_a_descifrar << linea
	end
end

texto_a_descifrar = c.decodificar(texto_a_descifrar)

File.open(ARGV[2], 'w') do |f|
	f << texto_a_descifrar
end
