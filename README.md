*Después de casi 18 años de inactividad, un grupo que se dedica a resolver problemas decidió volver a trabajar y nos contrató para modelar su sistema. Además quieren replicar su metodología de trabajo e instalar otros equipos en distintas ciudades.*

*Primero, comenzamos por los distintos tipos de  integrantes.*

*Tenemos a los planificadores, de los cuales conocemos su nombre, su edad, sus requisitos (código penal, biografías de pintores, muebles de pino, velador, ñoquis de espinca, vino tinto merlot, vinilos y fuego), su cantidad de dinero y si tiene fuego (nunca tiene);*

```java
class Planificador {
    const nombre
    const edad
    const requisitos = ["código penal", "biografías de pintores", "muebles de pino", "velador", "ñoquis de espinca", "vino tinto merlot", "vinilos", "fuego"]
    var dinero = 0
    const tieneFuego = false
}
```

*los caracterizadores, de los cuales conocemos su nombre, sus disfraces (NASA, vampiro, fiscal), su cantidad de dinero, su edad y su pseudónimo.*

```java
class Caracterizador {
    const nombre
    const edad
    const disfraces = ["NASA", "vampiro", "fiscal"]
    var dinero = 0
    const pseudonimo
}
```

*Cada integrante al terminar cada operativo cobra $5000. Además cuando son aceptados reciben un primer pago igual a lo que les corresponde por cada operativo.*

```java
// en ambas clases

method initialize() {
    self.cobrar()
}

method cobrar() {
    dinero += 5000
}
```

[Hasta acá armamos las dos clases `Planificador` y `Caracterizador`]

Repetición de lógica?
->
[Superclase `Simulador`]

```java
class Simulador {
    const nombre
    const edad
    var dinero = 0

    method initialize() {
        self.cobrar()
    }

    method cobrar() {
        dinero += 5000
    }
}

class Planificador inherits Simulador {
    const requisitos = ["código penal", "biografías de pintores", "muebles de pino", "velador", "ñoquis de espinca", "vino tinto merlot", "vinilos", "fuego"]
    const tieneFuego = false
}

class Caracterizador inherits Simulador {
    const disfraces = ["NASA", "vampiro", "fiscal"]
    const pseudonimo
}
```

*También tenemos otros dos tipos de integrantes*

*los técnicos, de los cuales tenemos como información adicional el equipamiento adquirido (un puma, un helicoptero, y betún) y el equipamiento pendiente (aquellos elementos que les hace falta conseguir). Como todavía no tienen un operativo asignado, no tienen ningún equipamiento pendiente.*

*A diferencia de los demás integrantes, ellos reciben $2000 por cada equipamiento adquirido.*

```java
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
}
```
```java
class Tecnico inherits Simulador {
    const equipamientoAdquirido = ["puma", "helicoptero", "betún"]
    var equipamientoPendiente = []

    override method dineroACobrar() = 1500 * equipamientoAdquirido.size()
}
```

*los investigadores, de los cuales no tenemos información adicional, pero sí sabemos que cobran 20% más que sus compañeros para cubrir viáticos.*

```java
class Investigador inherits Simulador {
    override method dineroACobrar() = super() * 1.2
}
```

*Como muchas veces se necesitan montar grandes simulacros, es común que se contraten extras, de los cuales solo sabemos su nombre. Aunque el pago a estos no entra dentro de las incumbencias del sistema, cada planificador va a saber quienes son los extras que están a su disposición.*

```java
class Extra {
    const nombre
}
```

```java
class Planificador inherits Simulador {
    const requisitos = ["código penal", "biografías de pintores", "muebles de pino", "velador", "ñoquis de espinca", "vino tinto merlot", "vinilos", "fuego"]
    const tieneFuego = false
    const extras
}
```

*Para saber con quien contar para los operativos, se necesita saber tanto si un simulador como un extra **puede simular***.

*En cuanto a los simuladores, necesitamos saber si estos pueden simular, pero esto dependerá de su tipo.*

```java
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
```

*los planificadores si tienen muebles de pino entre sus requisitos*
```java
method tieneRequisito(unRequisito) = requisitos.contains(unRequisito)

override method puedeSimular() = self.tieneRequisito("muebles de pino")
```

*los caracterizadores si su pseudónimo es Máximo Cozetti
```java
override method puedeSimular() = pseudonimo == "Máximo Cozetti"
```

*los técnicos si no tienen equipamiento pendiente*
```java
override method puedeSimular() = equipamientoPendiente.isEmpty()
```

*los investigadores siempre pueden simular*
```java
override method puedeSimular() = true
```

*A diferencia de los simuladores, los extras no pueden simular.*

```java
class Extra {
    const nombre
    
    method puedeSimular() = false
}
```