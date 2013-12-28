#!/usr/bin/env ruby
# encoding: utf-8

require 'zlib'
require_relative 'caesar.rb'

class ErrorEntrada_NumeroIncorrectoArgumentos < StandardError
end

class ErrorEntrada_ComandoDesconocido < StandardError
end

class ErrorEntrada_NoExisteFichero < StandardError
end

class ErrorEntrada_FicheroVacio < StandardError
end

if ARGV.count != 3 then raise ErrorEntrada_NumeroIncorrectoArgumentos, "El número de argumentos indicado es incorrecto." end

if ARGV[1] != "-o" then raise ErrorEntrada_ComandoDesconocido, "Se ha indicado un comando desconocido." end

if File.exists?(ARGV[0]) == false then raise ErrorEntrada_NoExisteFichero, "No existe el fichero indicado." end

if File.zero?(ARGV[0]) == true then raise ErrorEntrada_FicheroVacio, "El fichero indicado está vacío." end

c = CifradorCaesar.new(3)

texto_a_comprimir = ""

File.open(ARGV[0], 'r') do |f|
	while linea = f.gets
		texto_a_comprimir << linea
	end
end

texto_a_comprimir = c.codificar(texto_a_comprimir)
texto_a_comprimir = Zlib::Deflate.deflate(texto_a_comprimir)

File.open(ARGV[2], 'w') do |f|
	f << texto_a_comprimir
end
