//
//  AlumnoBE.swift
//  Sesion06-02
//
//  Created by Kenyi Rodriguez on 5/23/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation

class AlumnoBE {
    
    var alumno_nombre   = ""
    var alumno_apellido = ""
    var alumno_dni      = ""
    
    init(nombre: String, apellido: String, dni: String) {
        
        self.alumno_nombre      = nombre
        self.alumno_apellido    = apellido
        self.alumno_dni         = dni
    }
}
