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

if ARGV.count != 1 then raise ErrorEntrada_NumeroIncorrectoArgumentos, "El número de argumentos indicado es incorrecto." end

if File.exists?(ARGV[0]) == false then raise ErrorEntrada_NoExisteFichero, "No existe el fichero indicado." end

if File.zero?(ARGV[0]) == true then raise ErrorEntrada_FicheroVacio, "El fichero indicado está vacío." end

texto_a_forzar = ""

File.open(ARGV[0], 'r') do |f|
	while linea = f.gets
		texto_a_forzar << linea
	end
end

for i in 1..25
	c = CifradorCaesar.new(i)
	resultado = c.decodificar(texto_a_forzar)
	puts "Iteración [" + i.to_s + "]: " + resultado
end
