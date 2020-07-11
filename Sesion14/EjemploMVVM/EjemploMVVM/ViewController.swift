//
//  ViewController.swift
//  EjemploMVVM
//
//  Created by Kenyi Rodriguez on 7/11/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var arrayAlumnos: [AlumnoBE] = {
       
        var array = [AlumnoBE]()
        
        array.append(.init(nombre: "kenyi", apellido: "rodriguez", dni: "87654321"))
        array.append(.init(nombre: "Richard", apellido: "Cusi", dni: "76543218"))
        array.append(.init(nombre: "Pool", apellido: "Buiza", dni: "65432187"))
        array.append(.init(nombre: "Oscar", apellido: "Solari", dni: "54321876"))
        
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayAlumnos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "AlumnoTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlumnoTableViewCell
        cell.objAlumno = self.arrayAlumnos[indexPath.row]
        return cell
    }
}





//class ViewController: UIViewController {
//
//    @IBOutlet weak var lblInformacionCompleta: UILabel!
//    @IBOutlet weak var lblNombreCompleto: UILabel!
//
//    lazy var viewModel: AlumnoViewModel = {
//
//        let obj = AlumnoBE(nombre: "Kenyi", apellido: "Rodriguez", dni: "87654321")
//        let viewModel = AlumnoViewModel(objAlumno: obj)
//        return viewModel
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.lblInformacionCompleta.attributedText = self.viewModel.informacionGeneral
//        self.lblNombreCompleto.text = self.viewModel.nombreCompleto
//    }
//}

