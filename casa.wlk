object casa {
    const cuenta = cuentaCorriente
    var montoTotalDeGastos = 0

    method deposito(_saldo) {
        cuenta.saldo(_saldo) 
    }
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
        if (_saldo > costoPorOperacion) {
            saldo = saldo + _saldo - costoPorOperacion
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
}

