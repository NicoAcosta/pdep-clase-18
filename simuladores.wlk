class Simulador {
    const nombre
    const edad
    var dinero = 0

    method initialize() {
        self.cobrar()
    }

    // delegamos el dinero a cobrar
    method dineroACobrar() = 5000

    method cobrar() {
        dinero += self.dineroACobrar()
    }

    // agregamos el método abstracto
    method puedeSimular()
}

class Planificador inherits Simulador {
    const requisitos = ["código penal", "biografías de pintores", "muebles de pino", "velador", "ñoquis de espinca", "vino tinto merlot", "vinilos", "fuego"]
    const tieneFuego = false
    const extras

    method tieneRequisito(unRequisito) = requisitos.contains(unRequisito)

    override method puedeSimular() = self.tieneRequisito("muebles de pino")
}

class Caracterizador inherits Simulador {
    const disfraces = #{"NASA", "vampiro", "fiscal"}
    const pseudonimo

    override method puedeSimular() = pseudonimo == "Máximo Cozetti"
}

class Tecnico inherits Simulador {
    const equipamientoAdquirido = #{"puma", "helicoptero", "betún"}
    const equipamientoPendiente = #{}

    override method dineroACobrar() = 1500 * equipamientoAdquirido.size()

    override method puedeSimular() = equipamientoPendiente.isEmpty()
}

class Investigador inherits Simulador {
    override method dineroACobrar() = super() * 1.2

    override method puedeSimular() = true
}

class Extra {
    const nombre
    
    method puedeSimular() = false
}