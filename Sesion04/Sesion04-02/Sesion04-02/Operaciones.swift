//
//  File.swift
//  Sesion04-02
//
//  Created by Kenyi Rodriguez on 5/9/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation

protocol Imprimir {
    func imprimirTipoOperacion()
}

protocol Operaciones {
    func operarNumero1(_ n1: Double, conNumero2 n2: Double) -> Double
}


class Suma: Operaciones, Imprimir {
    
    func operarNumero1(_ n1: Double, conNumero2 n2: Double) -> Double {
        return n1 + n2
    }
    
    func imprimirTipoOperacion() {
        print("SOY UNA SUMA")
    }
}

class Resta: Operaciones, Imprimir {
    
    func operarNumero1(_ n1: Double, conNumero2 n2: Double) -> Double {
        return n1 - n2
    }
    
    func imprimirTipoOperacion() {
        print("SOY UNA RESTA")
    }
}

class Multiplicacion: Operaciones {
    
    func operarNumero1(_ n1: Double, conNumero2 n2: Double) -> Double {
        return n1 * n2
    }
}

class Division: Operaciones {
    
    func operarNumero1(_ n1: Double, conNumero2 n2: Double) -> Double {
        return n1 / n2
    }
}
