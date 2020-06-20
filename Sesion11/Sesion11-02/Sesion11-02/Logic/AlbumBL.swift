//
//  AlbumBL.swift
//  Sesion11-02
//
//  Created by Kenyi Rodriguez on 6/20/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation

class AlbumBL {
    
    class func getAlbums(_ success: @escaping Albums) {
        
        AlbumWS.getAlbums { (arrayAlbums) in
            
            let arraySorted = arrayAlbums.sorted(by: {
                return $0.album_name < $1.album_name
            })
            
            success(arraySorted)
        }
    }
}
