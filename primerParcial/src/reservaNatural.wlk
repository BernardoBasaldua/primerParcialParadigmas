import organismos.*

class ReservaNatural {
	var property habitats = []
	
	method habitatConMasSeresVivos() {
		return habitats.max({unHabitat => unHabitat.cantidadSeresVivos()})
	}
	
	method biomasaDeLaReserva() {
		return habitats.sum({unHabitat => unHabitat.biomasaDelHabitat()})
	}
	
	method habitatSinEquilibrio() {
		return habitats.any({unHabitat => unHabitat.estaEnEquilibrio() == not true}) 
	}
	
	method especieEnTodosLosHabitats(especie) {
		return !(habitats.any({unHabitat => !unHabitat.poseeEspecie(especie)}))	
	}
	
	method producirUnIncendio(habitat) {
		habitat.incendiarse()
	}
}

class Habitat {
	var property organismos = []
	
	method cantidadSeresVivos() {
		return organismos.filter({unSerVivo => unSerVivo.estaVivo()}).size()
	}
	
	method cantidadSeresMuertos() {
		return organismos.filter({unSerVivo => !unSerVivo.estaVivo()}).size()
	}
	
	method biomasaDelHabitat() {
		return organismos.sum({unSerVivo => unSerVivo.biomasa()})
	}
	
	method estaEnEquilibrio() {
		var ejemplaresGrandes = organismos.filter({unSerVivo => unSerVivo.esGrande()}).size()
		return (ejemplaresGrandes < (organismos.size() / 3)) 
		and (self.cantidadSeresVivos() > self.cantidadSeresMuertos())
	}
	
	method poseeEspecie(especie) {
		return organismos.filter({unOrganismo => unOrganismo.especie() == especie}).size() > 0
	}
	
	method incendiarse() {
		organismos.forEach({unOrganismo => unOrganismo.prenderseFuego()})
	}
}