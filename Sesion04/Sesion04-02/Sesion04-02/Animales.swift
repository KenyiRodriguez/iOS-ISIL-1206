//
//  Animales.swift
//  Sesion04-02
//
//  Created by Kenyi Rodriguez on 5/9/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation

protocol AnimalesGenerales {
    func respirar()
}

protocol Terrestre {
    
    var cantidadPatas: Int! {get set}
    
    func caminar()
    func correr()
}

protocol Aereo {
    
    func volar()
    func planear()
}

protocol Marino {
    
    func nadar()
    func bucear()
}


class Perro: Terrestre, Marino, AnimalesGenerales {
    
    var cantidadPatas: Int!
    
    func caminar() {
        print("ESTOY CAMINANDO")
    }
    
    func correr() {
        print("ESTOY CORRIENDO")
    }
    
    func nadar() {
        print("ESTOY NADANDO")
    }
    
    func bucear() {
        print("ESTOY BUCEANDO")
    }
    
    func respirar() {
        print("ESTOY RESPIRANDO")
    }
}

class Tiburon: Marino, AnimalesGenerales {
    
    func nadar() {
        print("ESTOY NADANDO")
    }
    
    func bucear() {
        print("ESTOY BUCEANDO")
    }
    
    func respirar() {
        print("ESTOY RESPIRANDO")
    }
}


class Gaviota: Terrestre, Aereo, Marino {
    
    var cantidadPatas: Int!
    
    func caminar() {
        print("ESTOY CAMINANDO")
    }
    
    func correr() {
        print("ESTOY CORRIENDO")
    }
    
    func nadar() {
        print("ESTOY NADANDO")
    }
    
    func bucear() {
        print("ESTOY BUCEANDO")
    }
    
    func volar() {
        print("ESTOY VOLANDO")
    }
    
    func planear() {
        print("ESTOY PLANEANDO")
    }
}
