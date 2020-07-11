//
//  AlumnoBE.swift
//  EjemploMVVM
//
//  Created by Kenyi Rodriguez on 7/11/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation

class AlumnoBE {
    
    var nombre  : String
    var apellido: String
    var dni     : String
    
    init(nombre: String, apellido: String, dni: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.dni = dni
    }
}
