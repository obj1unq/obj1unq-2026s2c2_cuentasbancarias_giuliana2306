object casa {
    const cuenta = cuentaCorriente
    var montoTotalDeGastos = 0
    var viveres = 0
    var montoDeReparaciones = 0
    var estrategia = 

    
    method extraer(_saldo) {
        cuenta.extraer(_saldo)
        montoTotalDeGastos = montoTotalDeGastos + _saldo
    }
    method montoTotalDeGastos() {
       return montoTotalDeGastos
    }
    method cambioDeMes() {
        montoTotalDeGastos = 0
    }
    method saldo() {
       return cuenta.saldo()
    }
    method viveres(porcentajeAComprar, calidad) {
        if (porcentajeAComprar + viveres > 100) {
            self.error("Supera el 100% de los viveres de la casa")
        } else {
          viveres = viveres + porcentajeAComprar 
          cuenta.extraer(porcentajeAComprar * calidad)
        }
    }
    method registrarReparacion(_montoDeReparaciones) {
        montoDeReparaciones = montoDeReparaciones + _montoDeReparaciones
    }
    method montoDeReparaciones() {
        return montoDeReparaciones
    }
    method repararCosas() {
        cuenta.extraer(montoDeReparaciones) 
        montoDeReparaciones = 0
    }
    method tieneViveresSuficientes() {
        return viveres >= 40
    }
    method hayQueRealizarReparaciones() {
        return montoDeReparaciones  > 0
    }
    method estaEnOrden() {
        return tieneViveresSuficientes() && not hayQueRealizarReparaciones()
    }
}

object cuentaCorriente {
    var saldo = 0

    method deposito(_saldo) {
        saldo = saldo + _saldo
    }
    method extraer(_saldo) {
        saldo = saldo - _saldo
    }
    method saldo() {
        return saldo
    }
}

object gastosDeMantenimiento { 
    var saldo = 0
    var costoPorOperacion = 0

    method deposito(_saldo) {
            self.validarDeposito(_saldo)
            saldo = saldo + _saldo - costoPorOperacion
    }
    method validarDeposito(_saldo) {
        if (_saldo <= costoPorOperacion) {
            self.error("No se puede depositar" + _saldo)
        }
    }
// pero no permite un depósito de un monto menor o igual al costo de operación.
    method extraer(_saldo) {
        saldo = saldo - _saldo
    }
    method saldo() {
        return saldo
    }
    method costoPorOperacion(_costoPorOperacion) {
        costoPorOperacion = _costoPorOperacion
    }
    method costoPorOperacion() {
    return costoPorOperacion
}
}

object cuentaCombinada {
    const cuentaPrimaria = cuentaCorriente
    const cuentaSecundaria = gastosDeMantenimiento

    method deposito(_saldo) {
        cuentaPrimaria.deposito(_saldo)
    }
    method extraer(_saldo) {  
        self.validarExtraer(_saldo)
        if (cuentaPrimaria.saldo() > _saldo) {
            cuentaPrimaria.extraer(_saldo) 
        } else {
            cuentaSecundaria.extraer(0.max(cuentaSecundaria.saldo()))
            cuentaPrimaria.extraer(0.max(cuentaPrimaria.saldo()))
        }
    }
    method validarExtraer(_saldo) {
        if (self.saldo() < _saldo) {
            self. error("No se puede extraer saldo" + _saldo)
        }
    }
    method saldo() {
        return 0.max(cuentaPrimaria.saldo()) + 0.max(cuentaSecundaria.saldo())
    }
}
 object minimoEIndispensable() {
    
 }

