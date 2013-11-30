#!/usr/bin/env ruby
# encoding: utf-8

require 'openssl'

begin
  File.open("usuarios.db", 'r')
rescue Errno::ENOENT
  File.open("usuarios.db", 'w')
end

respuesta1 = "0"
respuesta2 = "0"
respuesta3 = "0"

def existeUsuario?(usuario)
  if File.zero?("usuarios.db") then return false end
  File.open("usuarios.db", 'r') do |f|
    while linea = f.gets
      array = linea.split(' ')
      if (array[0] == usuario) then return true end
    end
  end
  return false
end

def comprobarContraseña(usuario, password)
  hash = OpenSSL::Digest::MD5.hexdigest(password)

  File.open("usuarios.db", 'r') do |f|
    while linea = f.gets
      array = linea.split(' ')
      if (array[0] == usuario)
        if (array[1] == hash) then return true end
      end
    end
  end
  return false
end

def crearUsuario(usuario, password)
  hash = OpenSSL::Digest::MD5.hexdigest(password)
  
  File.open("usuarios.db", 'a') do | f |
    f << usuario + " " + hash + "\n"
  end
end

while (respuesta1 != "")
  respuesta1 = "0"
  respuesta2 = "0"
  respuesta3 = "0"
  puts  "#########################################"
  puts  "# 1. Registro"
  puts  "# 2. Iniciar sesión"
  puts  "# ENTER. Salir"
  puts  "#----------------------------------------------"
  print "# Respuesta: "
  respuesta1 = STDIN.gets.chomp
  
  if (respuesta1 == "1")
    while (respuesta2 != "")
      respuesta2 = "0"
      respuesta3 = "0"
      puts  "#########################################"
      puts  "# Registro de usuario"
      puts  "#----------------------------------------------"
      puts  "# Introduce tu nombre de usuario."
      puts  "# ENTER. Volver al menú"
      puts  "#----------------------------------------------"
      print "# Respuesta: "
      respuesta2 = STDIN.gets.chomp
    
      if (respuesta2 != "")
        if (existeUsuario?(respuesta2) == false)
          while (respuesta3 != "")
            respuesta3 = ""
            puts  "#########################################"
            puts  "# Registro de usuario"
            puts  "#----------------------------------------------"
            puts  "# Introduce tu contraseña de usuario."
            puts  "# ENTER. Volver al menú"
            puts  "#----------------------------------------------"
            print "# Respuesta: "
            respuesta3 = STDIN.gets.chomp
            
            if (respuesta3 != "")
              crearUsuario(respuesta2, respuesta3)
              respuesta2 = ""
              respuesta3 = ""
              puts  "#########################################"
              puts  "# Registro de usuario"
              puts  "#----------------------------------------------"
              puts  "# Se ha creado el usuario satisfactoriamente."
              puts  "#----------------------------------------------"
              print "# Pulsa ENTER para continuar: "
              STDIN.gets.chomp
            elsif (respuesta3 == "")
              respuesta2 = ""
            end
          end
        else
          puts  "#########################################"
          puts  "# Registro de usuario"
          puts  "#----------------------------------------------"
          puts  "# ERROR: ya existe este usuario."
          puts  "#----------------------------------------------"
          print "# Pulsa ENTER para continuar: "
          STDIN.gets.chomp
        end
      end
    end
  elsif (respuesta1 == "2")
    while (respuesta2 != "")
      respuesta2 = "0"
      respuesta3 = "0"
      puts  "#########################################"
      puts  "# Iniciar sesión"
      puts  "#----------------------------------------------"
      puts  "# Introduce tu nombre de usuario."
      puts  "# ENTER. Volver al menú"
      puts  "#----------------------------------------------"
      print "# Respuesta: "
      respuesta2 = STDIN.gets.chomp
    
      if (respuesta2 != "")
        if (existeUsuario?(respuesta2) == true)
          while (respuesta3 != "")
            respuesta3 = ""
            puts  "#########################################"
            puts  "# Iniciar sesión"
            puts  "#----------------------------------------------"
            puts  "# Introduce tu contraseña de usuario."
            puts  "# ENTER. Volver al menú"
            puts  "#----------------------------------------------"
            print "# Respuesta: "
            respuesta3 = STDIN.gets.chomp
            
            if (respuesta3 != "")
              if (comprobarContraseña(respuesta2, respuesta3) == true)
                puts  "#########################################"
                puts  "# Iniciar sesión"
                puts  "#----------------------------------------------"
                puts  "# Ha iniciado sesión satisfactoriamente."
                puts  "#----------------------------------------------"
                print "# Pulsa ENTER para continuar: "
                STDIN.gets.chomp
              else
                puts  "#########################################"
                puts  "# Iniciar sesión"
                puts  "#----------------------------------------------"
                puts  "# ERROR: contraseña incorrecta."
                puts  "#----------------------------------------------"
                print "# Pulsa ENTER para continuar: "
                STDIN.gets.chomp
              end
              respuesta2 = ""
              respuesta3 = ""
            elsif (respuesta3 == "")
              respuesta2 = ""
            end
          end
        else
          puts  "#########################################"
          puts  "# Iniciar sesión"
          puts  "#----------------------------------------------"
          puts  "# ERROR: nombre de usuario incorrecto."
          puts  "#----------------------------------------------"
          print "# Pulsa ENTER para continuar: "
          STDIN.gets.chomp
        end
      end
    end
  end
  cambio
end