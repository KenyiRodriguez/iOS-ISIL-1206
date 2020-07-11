//
//  AlumnoViewModel.swift
//  EjemploMVVM
//
//  Created by Kenyi Rodriguez on 7/11/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class AlumnoViewModel {
     
    var informacionGeneral: NSAttributedString {
        
        let atributoDNI = NSAttributedString.createWith(text: self.objAlumno.dni, font: UIFont.boldSystemFont(ofSize: 28), color: .green)
        let atributoNombre = NSAttributedString.createWith(text: self.objAlumno.nombre, font: .systemFont(ofSize: 17), color: .red)
        let atributoApellido = NSAttributedString.createWith(text: self.objAlumno.apellido, font: UIFont.boldSystemFont(ofSize: 20), color: .blue)
        
        let atributoFinal = NSMutableAttributedString()
        atributoFinal.append(atributoDNI)
        atributoFinal.append(.createWith(text: " - "))
        atributoFinal.append(atributoNombre)
        atributoFinal.append(.createWith(text: " "))
        atributoFinal.append(atributoApellido)
        
        return atributoFinal
    }
    
    var nombreCompleto: String {
        return "\(self.objAlumno.nombre) \(self.objAlumno.apellido)"
    }
    
    private var objAlumno: AlumnoBE
    
    init(objAlumno: AlumnoBE) {
        self.objAlumno = objAlumno
    }
}
