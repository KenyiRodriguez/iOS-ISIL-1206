//
//  ViewController.swift
//  Sesion06-02
//
//  Created by Kenyi Rodriguez on 5/23/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var arrayAlumnos = [AlumnoBE]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrayAlumnos.append(AlumnoBE(nombre: "Angel Kenyi", apellido: "Rodriguez Vergara", dni: "87654321"))
        self.arrayAlumnos.append(AlumnoBE(nombre: "Pool", apellido: "Buiza", dni: "65432187"))
        self.arrayAlumnos.append(AlumnoBE(nombre: "Alvaro", apellido: "Chavarry", dni: "43218765"))
        self.arrayAlumnos.append(AlumnoBE(nombre: "Sebastian", apellido: "Tirado", dni: "21876543"))
    }
    
    func crearActionEliminar(tableView: UITableView, indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .destructive, title: "Eliminar") { (_, _, _) in
            
            self.arrayAlumnos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return action
    }
    
    func crearActionDetalle(tableView: UITableView, indexPath: IndexPath) -> UIContextualAction {
        
        let action = UIContextualAction(style: .normal, title: "Ver detalle") { (_, _, _) in
            let objAlumno = self.arrayAlumnos[indexPath.row]
            self.performSegue(withIdentifier: "DetalleAlumnoViewController", sender: objAlumno)
        }
        
        return action
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? DetalleAlumnoViewController {
            controller.objAlumno = sender as? AlumnoBE
        }
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionEliminar = self.crearActionEliminar(tableView: tableView, indexPath: indexPath)
        let actionDetalle = self.crearActionDetalle(tableView: tableView, indexPath: indexPath)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [actionEliminar, actionDetalle])
        return swipeConfiguration
    }
}

