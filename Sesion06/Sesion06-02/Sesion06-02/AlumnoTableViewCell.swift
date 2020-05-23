//
//  AlumnoTableViewCell.swift
//  Sesion06-02
//
//  Created by Kenyi Rodriguez on 5/23/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class AlumnoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblDni: UILabel!
    
    var objAlumno: AlumnoBE!{
        didSet{
            self.actualizarData()
        }
    }
    
    func actualizarData() {
        
        self.lblNombre.text = "\(self.objAlumno.alumno_apellido) \(self.objAlumno.alumno_nombre)"
        self.lblDni.text = self.objAlumno.alumno_dni
    }
}
