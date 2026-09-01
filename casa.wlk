object casa {
    const cuenta = cuentaCorriente
    var montoTotalDeGastos = 0

    method saldo(_saldo) {
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

    method saldo(_saldo) {
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

    method saldo(_saldo, costoPorOp) {
        if (_saldo > costoPorOp) {
            saldo = saldo + _saldo - costoPorOp
        } 
    }
    // pero no permite un depósito de un monto menor o igual al costo de operación.
    method extraer(_saldo) {
        saldo = saldo - _saldo
    }
    method saldo() {
        return saldo
    }
}

