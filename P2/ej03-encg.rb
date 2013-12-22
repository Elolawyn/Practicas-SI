#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'caesar.rb'

class ErrorEntrada_NumeroIncorrectoArgumentos < StandardError
end

class ErrorEntrada_DesplazamientoNoPositivo < StandardError
end

class ErrorEntrada_ComandoDesconocido < StandardError
end

class ErrorEntrada_NoExisteFichero < StandardError
end

class ErrorEntrada_FicheroVacio < StandardError
end

llamada_correcta = "\nEjemplo de llamada: ruby ej03_encg.rb <desplazamiento> <fichero_a_encriptar> -o <salida>"

if ARGV.count != 4 then raise ErrorEntrada_NumeroIncorrectoArgumentos, "\nEl número de argumentos indicado es incorrecto." + llamada_correcta end

if ARGV[0].to_i <= 0 then raise ErrorEntrada_DesplazamientoNoPositivo, "\nEl desplazamiento de la encriptación Caesar debe ser un número positivo." + llamada_correcta end

if ARGV[2] != "-o" then raise ErrorEntrada_ComandoDesconocido, "\nNo existe el comando \"" + ARGV[1] + "\"." + llamada_correcta end

if File.exists?(ARGV[1]) == false then raise ErrorEntrada_NoExisteFichero, "\nNo existe el fichero \"" + ARGV[0] + "\""+ llamada_correcta end

if File.zero?(ARGV[1]) == true then raise ErrorEntrada_FicheroVacio, "\nEl fichero \"" + ARGV[0] + "\" está vacío. " + llamada_correcta end

c = CifradorCaesar.new(ARGV[0].to_i)

texto_a_cifrar = ""

File.open(ARGV[1], 'r') do |f|
	while linea = f.gets
		texto_a_cifrar << linea
	end
end

texto_a_cifrar = c.codificar(texto_a_cifrar)

File.open(ARGV[3], 'w') do |f|
	f << texto_a_cifrar
end
