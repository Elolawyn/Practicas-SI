#!/usr/bin/env ruby
# encoding: utf-8

require 'openssl'

class ErrorEntrada_NumeroIncorrectoArgumentos < StandardError
end

class ErrorEntrada_ErrorComando < StandardError
end

class ErrorEntrada_AlgoritmoIncorrecto < StandardError
end

class ErrorEntrada_NoExisteFichero < StandardError
end

class ErrorEntrada_FicheroVacio < StandardError
end

#Llamadas al programa
#0 1 2 3 4 5
#-f fichero -h hash -a algoritmo 6
#-f fichero -h hash 4
#-c fichero fichero -a algoritmo 5
#-c fichero fichero 3
#-f fichero -a algoritmo 4
#-f fichero 2

system 'clear'

numero_argumentos = ARGV.count

bloquef = 0
bloquec = 0
bloquefh = 0
bloquea = 0
algoritmo = "MD5"

if (numero_argumentos == 2) # Operación -f
  if ARGV[0] != "-f" then raise ErrorEntrada_ErrorComando, "No se ha invocado correctamente al programa." end
  bloquef = 1
elsif (numero_argumentos == 3) # Operación -c
  if ARGV[0] != "-c" then raise ErrorEntrada_ErrorComando, "No se ha invocado correctamente al programa." end
  bloquec = 1
elsif (numero_argumentos == 4) # Operación -f -h, -f -a
  if ARGV[0] != "-f" then raise ErrorEntrada_ErrorComando, "No se ha invocado correctamente al programa." end
  if (ARGV[2] == "-h")
    bloquefh = 1
  elsif (ARGV[2] == "-a")
    bloquef = 1
    bloquea = 1
  else
    raise ErrorEntrada_ErrorComando, "No se ha invocado correctamente al programa." 
  end
elsif (numero_argumentos == 5) # Operación -c, -a
  if ARGV[0] != "-c" then raise ErrorEntrada_ErrorComando, "No se ha invocado correctamente al programa." end
  if ARGV[3] != "-a" then raise ErrorEntrada_ErrorComando, "No se ha invocado correctamente al programa." end
  bloquec = 1
  bloquea = 1
elsif (numero_argumentos == 6) # Operación -f -h -a
  if ARGV[0] != "-f" then raise ErrorEntrada_ErrorComando, "No se ha invocado correctamente al programa." end
  if ARGV[2] != "-h" then raise ErrorEntrada_ErrorComando, "No se ha invocado correctamente al programa." end
  if ARGV[4] != "-a" then raise ErrorEntrada_ErrorComando, "No se ha invocado correctamente al programa." end
  bloquefh = 1
  bloquea = 1
else # Error
  raise ErrorEntrada_NumeroIncorrectoArgumentos, "El número de argumentos indicado es incorrecto."
end

# Obtención del algoritmo
if (bloquea == 1)
  algoritmo = ARGV[numero_argumentos-1]
  if (algoritmo != "MD5" and algoritmo != "SHA") then raise ErrorEntrada_AlgoritmoIncorrecto, "No se ha indicado un algoritmo de hash correcto." end  
end

if (algoritmo == "MD5")
  hasheador = OpenSSL::Digest::MD5.new()
end
if (algoritmo == "SHA")
  hasheador = OpenSSL::Digest::SHA1.new()
end

# Bloque F
if (bloquef == 1)
  fichero1 = ARGV[1]
  if File.exists?(fichero1) == false then raise ErrorEntrada_NoExisteFichero, "No existe el fichero indicado." end
  if File.zero?(fichero1) == true then raise ErrorEntrada_FicheroVacio, "El fichero indicado está vacío." end
    
  datos = File.read(fichero1)
  hash = hasheador.hexdigest(datos)

  puts algoritmo + " de '" + fichero1 + "': " + hash
end
# Bloque C
if (bloquec == 1)
  fichero1 = ARGV[1]
  if File.exists?(fichero1) == false then raise ErrorEntrada_NoExisteFichero, "No existe el fichero indicado." end
  if File.zero?(fichero1) == true then raise ErrorEntrada_FicheroVacio, "El fichero indicado está vacío." end
  
  fichero2 = ARGV[2]
  if File.exists?(fichero2) == false then raise ErrorEntrada_NoExisteFichero, "No existe el fichero indicado." end
  if File.zero?(fichero2) == true then raise ErrorEntrada_FicheroVacio, "El fichero indicado está vacío." end
  
  datos = File.read(fichero1)
  hash = hasheador.hexdigest(datos)

  datos2 = File.read(fichero2)
  hash2 = hasheador.hexdigest(datos2)

  puts algoritmo + " de '" + fichero1 + "': " + hash
  puts algoritmo + " de '" + fichero2 + "': " + hash2

  if (hash == hash2) then puts "Los 2 ficheros son iguales" else puts "Los 2 ficheros no son iguales" end
end
# Bloque FH
if (bloquefh == 1)
  fichero1 = ARGV[1]
  if File.exists?(fichero1) == false then raise ErrorEntrada_NoExisteFichero, "No existe el fichero indicado." end
  if File.zero?(fichero1) == true then raise ErrorEntrada_FicheroVacio, "El fichero indicado está vacío." end
    
  datos = File.read(fichero1)
  hash = hasheador.hexdigest(datos)

  hash_entrada = ARGV[3]

  puts algoritmo + " de '" + fichero1 + "': " + hash
  puts algoritmo + " de entrada: " + hash_entrada

  if (hash == hash_entrada) then puts "El hash indicado es igual al del fichero" else puts "El hash indicado es distinto al del fichero" end
end