class Nave{
	var property velocidad 
	var property alarma = false 

	const property velocidadDePropulsion = 20000
	const property velocidadAlPrepararse = 15000 

	method recibirAmenaza(){
		alarma = true 
	}
	method propulsar(){
		if(velocidad + velocidadDePropulsion > 300000){
			self.limitarVelocidad()
		}else{
			velocidad = velocidad + velocidadDePropulsion
		}
	}
	method prepararParaViajar(){
		if(velocidad + velocidadAlPrepararse > 300000){
			self.limitarVelocidad()
		}else{
			velocidad = velocidad + velocidadAlPrepararse
		}
	}
	method limitarVelocidad(){
		velocidad = 300000
	}
	method encontrarseConEnemigo(){
		self.recibirAmenaza()
		self.propulsar()
	}
}
//Se creo esta clase ya que, estos atributos y metodos van a usar en todas las otras clases de naves 
//De esta clase van a heredar las siguientes 3; NaveDeCarga, NaveDePAsajeros, NaveDeCombate
class NaveDeCarga inherits Nave{
	var property carga 

	method estaSobrecargada(){
		return carga > 100 
	} 
	method estaExcedidaDeVelocidad(){
		return velocidad > 100.000
	}
	override method recibirAmenaza(){
		carga = 0 
	}
}
class NaveDePasajeros inherits Nave{
	var property cantDePasajeros 
	const property tripulacion = 4 
	const property penalizacionPorSeguridad = 200 

	method cantTotalDePersonas(){
		return cantDePasajeros + tripulacion 
	} 
	method velocidadMaximaLegal(){
		if(cantDePasajeros <= 100){
			return 300.000.div(cantDePasajeros)
		}else{
			return 300.000.div(cantDePasajeros) - penalizacionPorSeguridad
		}
	}
	method estaEnPeligro(){
		return self.excedeVelocidadMaximaLegal() || self.alarmaEstaEncendida()
	}
	method excedeVelocidadMaximaLegal(){
		return velocidad > self.excedeVelocidadMaximaLegal()
	}
	method alarmaEstaEncendida(){
		return alarma 
	}
	/*method penalizacionPorPasajeros(){
		return (cantDePasajeros - 100) * 200 
	}*/

}
class NaveDeCombate inherits Nave{
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje){
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}
	override method prepararParaViajar(){
		super()
		modo.prepararParaViajar(self)
	}
}
class NaveCargaResiduos inherits NaveDeCarga{
	var property estaSelladaAlVacio = false  //esto debe ser una flag o un estado, que implica? 

	override method recibirAmenaza(){
		velocidad = 0 
	}
	override method prepararParaViajar(){
		super()
		estaSelladaAlVacio = true 
	}
}

//ESTADOS 
object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method prepararParaViajar(nave){
		nave.emitirMensaje(" Saliendo en mision ")
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method prepararParaViajar(nave){
		nave.emitirMensaje(" Volviendo a la base ")
	}
}






/*class NaveDeCarga {

	var velocidad = 0
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	method recibirAmenaza() {
		carga = 0
	}

}

class NaveDePasajeros {

	var velocidad = 0
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate {
	var property velocidad = 0
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

}*/

