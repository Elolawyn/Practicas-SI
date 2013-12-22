#!/usr/bin/env ruby
# encoding: utf-8

class CifradorCaesar
	#-----------------------------------------------------------------------------
	CODIFICAR = 1
	DECODIFICAR = -1
	#-----------------------------------------------------------------------------
	@offset
	@alfabeto
	#-----------------------------------------------------------------------------
	def initialize(offset = 1, clave = "")
		self.offset = offset
		if (clave == "")
			self.alfabeto = abc()
		else
			self.alfabeto = desordenar(clave)
		end
	end
	#-----------------------------------------------------------------------------
	public
	#-----------------------------------------------------------------------------
	def codificar(string)
		cifrador(CODIFICAR, string)
	end
	#-----------------------------------------------------------------------------
	def decodificar(string)
		cifrador(DECODIFICAR, string)
	end
	#-----------------------------------------------------------------------------
	attr_accessor :offset, :alfabeto
	#-----------------------------------------------------------------------------
	private
	#-----------------------------------------------------------------------------
	def cifrador(modo, string)
		cadena = ""

		string.chars.each do |c| 
			indice = self.alfabeto.index(c)
			if (indice.nil?)
				cadena << c
			else
				cadena << self.alfabeto[(indice + modo * offset) % self.alfabeto.count]
			end
		end
		return cadena
	end
	#-----------------------------------------------------------------------------
	def abc()
		alfabeto = (" ".."Z").to_a
		alfabeto = alfabeto.concat(("a".."z").to_a)
		return alfabeto
	end
	#-----------------------------------------------------------------------------
	def desordenar(clave)
		alfabeto_original = abc()
		nuevo_alfabeto = []
		nueva_clave = ""
		posicion = self.offset

		clave.chars.each do |c|
			if (nueva_clave.index(c).nil?)
				nueva_clave << c	
			end
		end

		nueva_clave.chars.each do |c|
			nuevo_alfabeto[posicion] = c
			posicion = posicion + 1
		end

		for c in alfabeto_original
			if (nuevo_alfabeto.index(c).nil? and nuevo_alfabeto[posicion] == nil)
				nuevo_alfabeto[posicion] = c
				posicion = posicion + 1
			end
			if (posicion == (abc().length)) then posicion = 0 end
		end

		return nuevo_alfabeto
	end
end
