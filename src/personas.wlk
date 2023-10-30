import hogar.*

class Familia{
 	const integrantes = []
 	const casaActual = []
    
	method confortPromedio(casa) = self.sumaDeConfort(casa) / self.cantidadDeIntegrantes()
    method cantidadDeIntegrantes() = if(integrantes.isEmpty()) self.error("No hay integrantes en la familia") else integrantes.size()
    method sumaDeConfort(casa) = integrantes.sum({x=>x.confort(casa)})
    method estaAGusto(casa) = self.confortPromedio(casa) > 40 and integrantes.all({x=>x.estaAGusto()})
}
	
class Persona{
	var property habitacionActual = null
	var edad 
	var property tieneHabilidadesDeCocina = false
	
	method edad() = edad
	method confort(casa) = casa.habitaciones().sum({x=>x.nivelDeConfort(self)})
	method estaAGusto()
}

class Obsesives inherits Persona{
	
}

class Goloses inherits Persona{
	
}

class Sencilles inherits Persona{
	
}