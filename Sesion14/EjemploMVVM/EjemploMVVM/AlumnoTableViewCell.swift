//
//  AlumnoTableViewCell.swift
//  EjemploMVVM
//
//  Created by Kenyi Rodriguez on 7/11/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class AlumnoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblInformacionGeneral: UILabel!
    
    var objAlumno: AlumnoBE! {
        didSet{
            self.updateData()
        }
    }

    private func updateData() {
        
        let viewModel = AlumnoViewModel(objAlumno: self.objAlumno)
        self.lblInformacionGeneral.attributedText = viewModel.informacionGeneral
    }
}
