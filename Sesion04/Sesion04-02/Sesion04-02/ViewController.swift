//
//  ViewController.swift
//  Sesion04-02
//
//  Created by Kenyi Rodriguez on 5/9/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let operacion = Multiplicacion()
        let resultado = operacion.operarNumero1(10, conNumero2: 12)
        print(resultado)
        
        let objAnimal = Perro()
        objAnimal.bucear()
    }
}

