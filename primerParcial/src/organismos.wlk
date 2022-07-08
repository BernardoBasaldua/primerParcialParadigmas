import reservaNatural.*

class Organismo {
	var property edad
	var property especie
}

class Fauna inherits Organismo {	
	var property biomasa = peso + edad
	var property peso
	var property locomocion
	
	method esPequenio() {
		return peso < 30
	}
	
	method esGrande() {
		return (peso > 60) and (edad > 10)
	}
	
	method morir() {
		biomasa = 0
	}
	
	method prenderseFuego() {
		locomocion.reaccion(self)
	}
	
	method estaVivo() {
		return biomasa > 0
	}
	
	method perderPeso() {
		peso = (peso - peso*0.1)
	}
}

object volar{
	method reaccion(organismo) {
		if(!organismo.esGrande()) {
			organismo.morir()
			organismo.perderPeso()
		}
	}
}
object nadar{
	method reaccion(organismo) {}
}
object correr{
	method reaccion(organismo) {
		if(organismo.esPequenio()==not false or organismo.esGrande()==not false) {
			organismo.morir()
		}
	}
}
object quieto{
	method reaccion(organismo) {
		organismo.morir()
	}
}

class Flora inherits Organismo {
	var property altura
	var property biomasa = edad
	
	method esPequenio() {
		return altura < 10
	}
	
	method esGrande() {
		return !self.esPequenio()
	}
	
	method prenderseFuego() {
		if(self.esPequenio()) {
			biomasa = 0
		} else {
			altura -= 5
		}
	}
	
	method estaVivo() {
		return biomasa > 0
	}
}