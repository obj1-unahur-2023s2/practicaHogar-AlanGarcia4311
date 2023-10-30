class Casa{
	const habitaciones = []
	
	method habitaciones() = habitaciones
	method responsables() = habitaciones.map({x=>x.masViejo()})	
}

class Habitacion{
	const personasDentro = #{}
	
	method masViejo() = personasDentro.max({x=>x.edad()})
	method personasDentro() = personasDentro
	method nivelDeConfort(persona) = 10
	method puedeEntrar(persona) = personasDentro.isEmpty() and not personasDentro.contains(persona)
	method entrar(persona) { 
		if (persona.habitacionActual() != null) persona.habitacionActual().salir(persona)
		if(not self.puedeEntrar(persona)) self.error("dicha persona no puede entrar")
		else { 	personasDentro.add(persona) 
			 	persona.habitacionActual(self) }
	}
	method salir(persona) { if(not personasDentro.contains(persona)) self.error("dicha persona no se encuentra en la habitación")
							else personasDentro.remove(persona)
	}
}

class UsoGeneral inherits Habitacion{
	override method puedeEntrar(persona) = true
} 

class Dormitorio inherits Habitacion{	
	const dormidos = #{}
	
	method estaDurmiendo(persona) = dormidos.contains(persona)
	override method nivelDeConfort(persona) = super(persona) + if(self.estaDurmiendo(persona)) 10 / dormidos.size() else 0
	override method puedeEntrar(persona) = super(persona) and dormidos.contains(persona) or personasDentro.all({x=>dormidos.contains(x)})
	
}

class Banio inherits Habitacion{
	override method nivelDeConfort(persona) = super(persona) + if(persona.edad() <= 4) 2 else 5 
	override method puedeEntrar(persona) = super(persona) and personasDentro.any({x=>x.edad() <= 4})
}

object porcentaje{
	var property valor = 0.1
}

class Cocina inherits Habitacion{
	var m2

	method porcentaje() = porcentaje.valor() * m2
	override method nivelDeConfort(persona) = super(persona) + if(persona.tieneHabilidadesDeCocina()) self.porcentaje() else 0
	override method puedeEntrar(persona) = super(persona) and if(persona.tieneHabilidadesDeCocina()) 
																personasDentro.filter({x=>x.tieneHabilidadesDeCocina()}).size() <= 1
															else true
}