#!/usr/bin/env ruby
# encoding: utf-8

require 'openssl'

class ErrorEntrada_NumeroIncorrectoArgumentos < StandardError
end

class ErrorEntrada_AlgoritmoDesconocido < StandardError
end

class ErrorEntrada_ComandoDesconocido < StandardError
end

class ErrorEntrada_NoExisteFichero < StandardError
end

class ErrorEntrada_FicheroVacio < StandardError
end

llamada_correcta = "\nEjemplo de llamada: ruby ej13.rb -f <fichero_a_desencriptar> -k <clave> [-a <algoritmo>]\n  Algoritmos disponibles:\n    AES\n    DES"
algoritmo = "AES-128-CBC"

if ARGV.count != 6 and ARGV.count != 4 then raise ErrorEntrada_NumeroIncorrectoArgumentos, "\nEl número de argumentos indicado es incorrecto." + llamada_correcta end

if ARGV[0] != "-f" then raise ErrorEntrada_ComandoDesconocido, "\nNo existe el comando \"" + ARGV[0] + "\"." + llamada_correcta end

if ARGV[2] != "-k" then raise ErrorEntrada_ComandoDesconocido, "\nNo existe el comando \"" + ARGV[2] + "\"." + llamada_correcta end

if ARGV.count == 6
  if ARGV[4] != "-a" then raise ErrorEntrada_ComandoDesconocido, "\nNo existe el comando \"" + ARGV[4] + "\"." + llamada_correcta end
  algoritmo = ARGV[5]
  if (algoritmo != 'AES' and algoritmo != 'DES') then raise ErrorEntrada_AlgoritmoDesconocido, "\nNo existe el algoritmo \"" + ARGV[5] + "\"." + llamada_correcta end
  if algoritmo == "DES"
    algoritmo = "DES"
  elsif algoritmo == "AES"
    algoritmo = "AES-128-CBC"
  end
end

if File.exists?(ARGV[1]) == false then raise ErrorEntrada_NoExisteFichero, "\nNo existe el fichero \"" + ARGV[1] + "\""+ llamada_correcta end

if File.zero?(ARGV[1]) == true then raise ErrorEntrada_FicheroVacio, "\nEl fichero \"" + ARGV[1] + "\" está vacío. " + llamada_correcta end

clave = ARGV[3]

c = OpenSSL::Cipher.new(algoritmo)
c.decrypt
c.key = clave

texto_a_descifrar = ""

File.open(ARGV[1], 'r') do |f|
  while linea = f.gets
    texto_a_descifrar << linea
  end
end

texto_a_descifrar = c.update(texto_a_descifrar)

File.open(ARGV[1] + '.descifrado', 'w') do |f|
  f << texto_a_descifrar
end