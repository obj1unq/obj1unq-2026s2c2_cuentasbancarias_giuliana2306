object casa {
    var cuenta = cuentaCorriente
    var montoTotalDeGastos = 0
    var viveres = 0
    var reparaciones = 0
    var montoDeReparacion = 0
    var estrategia = minimoEIndispensable

    method gasto(_gasto) {
        cuenta.extraer(_gasto)
        montoTotalDeGastos = montoTotalDeGastos + _gasto
    }
    method alcanzaParaPagarReparacion() {
        return cuenta.saldo() >= montoDeReparacion
    }
    method cambioDeMes() {
        montoTotalDeGastos = 0
        estrategia.aplicarEstrategiaDeAhorro()
        montoTotalDeGastos = 0
    }
    method montoTotalDeGastos() {
        return montoTotalDeGastos
    }
    method cambiarCuenta(_cuenta) {
        cuenta = _cuenta
    }
    method comprar(porcentajeDeViveres, calidad) {
        self.validarComprar(porcentajeDeViveres, calidad)
        self.gasto(porcentajeDeViveres * calidad)
        viveres = viveres + porcentajeDeViveres
    }
    method validarComprar(porcentajeDeViveres, calidad) {
        if (viveres + porcentajeDeViveres > 100) {
            self.error("No se puede comprar el porcentaje de viveres" + porcentajeDeViveres)
        }
    }
    method tieneViveresSuficientes() {
        return viveres >= 40
    }
    method cambiarCantidadDeViveres(porcentajeDeViveres) {
        viveres = porcentajeDeViveres
    }
    method realizarReparacion() {
        self.gasto(montoDeReparacion)
        montoDeReparacion = 0
        reparaciones = reparaciones - 1
    }
    method seRompio(_montoDeReparacion) {
        montoDeReparacion = montoDeReparacion + _montoDeReparacion
        reparaciones = reparaciones + 1
    }
    method hayQueHacerReparaciones() {
        return reparaciones > 0
    }
    method estaEnOrden() {
        return not self.hayQueHacerReparaciones() && self.tieneViveresSuficientes()
    }
    method viveres() {
        return viveres
    }
    method estrategia(_estrategia) {
        estrategia = _estrategia
    }
    method montoDeReparacion() {
    return montoDeReparacion
}
    method reparaciones() {
        return reparaciones
    }
}

object cuentaCorriente {
    var saldo = 0

    method saldo() {
        return saldo
    }
    method depositar(_saldo) {
        saldo = saldo + _saldo
    }
    method extraer(_saldo) {
        saldo = saldo - _saldo
    }
}

object cuentaDeGastosDeMantenimiento {
    var saldo = 0
    var costoDeOperacion = 0

    method depositar(_saldo) {
        self.validarDepositar(_saldo)
        saldo = saldo + _saldo - costoDeOperacion
    }
    method validarDepositar(_saldo) {
        if (_saldo <= costoDeOperacion) {
            self.error("No se permite un deposito de monto" + _saldo)
        }
    }
    method extraer(_saldo) {
        saldo = saldo - _saldo
    }
    method saldo() {
        return saldo
    }
    method costoDeOperacion(_costoDeOperacion) {
        costoDeOperacion = _costoDeOperacion
    }
}

object cuentaCombinada {
    var cuentaPrimaria = cuentaDeGastosDeMantenimiento
    var cuentaSecundaria = cuentaCorriente
    var saldoRestanteAExtraer = 0

    method depositar(_saldo) {
        cuentaDeGastosDeMantenimiento.depositar(_saldo)
    }
    method saldo() {
        return 0.max(cuentaPrimaria.saldo()) + 0.max(cuentaSecundaria.saldo())
    }
    method extraer(_saldo) {
        self.validarExtraer(_saldo)
        if (0.max(cuentaPrimaria.saldo()) >= _saldo) {
            cuentaPrimaria.extraer(_saldo)
        } else {
            saldoRestanteAExtraer = _saldo - 0.max(cuentaPrimaria.saldo())
            cuentaPrimaria.extraer(0.max(cuentaPrimaria.saldo()))
            cuentaSecundaria.extraer(0.max(saldoRestanteAExtraer))
        }
    }
    method validarExtraer(_saldo) {
        if (self.saldo() < _saldo) {
            self.error("No se puede realizar extracción de" + _saldo)
        }
    }
}

object minimoEIndispensable {
    var calidad = 0

    method aplicarEstrategiaDeAhorro() {
        if (not casa.tieneViveresSuficientes()) {
            casa.comprar(40 - casa.viveres(), calidad)
        }
    }
    method calidad(_calidad) {
        calidad = _calidad
    }
}

object full {
    var calidad = 5

    method aplicarEstrategiaDeAhorro() {
        if (casa.estaEnOrden()) {
            if (casa.viveres() < 100) {
                casa.comprar(100 - casa.viveres(), calidad)
            }
        } else {
            if (not casa.tieneViveresSuficientes()) {
                casa.comprar(40 - casa.viveres(), calidad)
            }

            if (casa.hayQueHacerReparaciones() && casa.alcanzaParaPagarReparacion()) {
                casa.realizarReparacion()
            }
        }
    }
}