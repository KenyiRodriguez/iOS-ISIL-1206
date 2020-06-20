//
//  AlbumWS.swift
//  Sesion11-02
//
//  Created by Kenyi Rodriguez on 6/20/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation

class AlbumWS {

    class func getAlbums(_ success: @escaping Albums) {
        
        let url = "http://kenyirodriguez.com/discos.json"
        
        CSMWebServiceManager.shared.request.getRequest(urlString: url, parameters: nil) { (response) in
            
            let arrayAlbumsWS = response.JSON?.dictionary["productos"]?.dictionary["discos"]?.array ?? []
            
            var arrayAlbumsApp = [AlbumBE]()
            
            for objAlbumWS in arrayAlbumsWS {
                let objAlbumApp = AlbumBE.parse(objAlbumWS)
                arrayAlbumsApp.append(objAlbumApp)
            }
            
            success(arrayAlbumsApp)
        }
    }
}
