//
//  AlbumBE.swift
//  Sesion11-02
//
//  Created by Kenyi Rodriguez on 6/20/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation

class AlbumBE {
    
    var album_id            = 0
    var album_name          = ""
    var album_author        = ""
    var album_releaseYear   = 0
    var album_genre         = ""
    var album_urlImage      = ""
    var album_price         = ""
    var album_description   = ""
    var album_company       = ""
    
    class func parse(_ json: CSMJSON) -> AlbumBE {
        
        let objBE = AlbumBE()
        
        objBE.album_id          = json.dictionary["id"]?.intValue ?? 0
        objBE.album_name        = json.dictionary["nombre"]?.stringValue ?? "Nombre no disponible"
        objBE.album_author      = json.dictionary["autor"]?.stringValue ?? ""
        objBE.album_releaseYear = json.dictionary["publicacion"]?.intValue ?? 0
        objBE.album_genre       = json.dictionary["genero"]?.stringValue ?? ""
        objBE.album_urlImage    = json.dictionary["urlImagen"]?.stringValue ?? ""
        objBE.album_price       = json.dictionary["precio"]?.stringValue ?? ""
        objBE.album_description = json.dictionary["descripcion"]?.stringValue ?? ""
        objBE.album_company     = json.dictionary["discografica"]?.stringValue ?? ""
        
        return objBE
    }
}

//CODABLE
