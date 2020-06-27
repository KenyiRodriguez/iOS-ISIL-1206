//
//  ViewController.swift
//  Sesion12-01
//
//  Created by Kenyi Rodriguez on 6/27/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceBE {
    var place_address = ""
    var place_name = ""
    var place_coordinate: CLLocationCoordinate2D
    
    init(address: String, name: String, coordinate: CLLocationCoordinate2D) {
        self.place_name = name
        self.place_address = address
        self.place_coordinate = coordinate
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    lazy var arrayPlaces: [PlaceBE] = {
       
        var array = [PlaceBE]()
        array.append(PlaceBE(address: "Av. Benavides", name: "ISIL Miraflores", coordinate: CLLocationCoordinate2D(latitude: -12.125465, longitude: -77.024815)))
        array.append(PlaceBE(address: "Av. Salaverry", name: "ISIL San Isidro", coordinate: CLLocationCoordinate2D(latitude: -12.093831, longitude: -77.052920)))
        array.append(PlaceBE(address: "Av. La Fontana", name: "ISIL La Molina", coordinate: CLLocationCoordinate2D(latitude: -12.073360, longitude: -76.948017)))
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.settings.myLocationButton = true
        self.mapView.isMyLocationEnabled = true
        
        self.arrayPlaces.forEach { (objPlace) in
            self.createMarkerToPlace(objPlace)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let coordinate = self.mapView.myLocation?.coordinate {
            self.moveCameraToCoordinate(coordinate)
        }
    }
    
    func moveCameraToCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition(target: coordinate, zoom: 16)
        self.mapView.animate(to: camera)
    }
    
    func createMarkerToCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.icon = UIImage(systemName: "flag.fill")
        marker.map = self.mapView
    }
    
    func createMarkerToPlace(_ place: PlaceBE) {
        
        let marker = GMSMarker(position: place.place_coordinate)
        marker.icon = UIImage(systemName: "flag.fill")
        marker.userData = place
        marker.map = self.mapView
    }
}

extension ViewController: GMSMapViewDelegate {
    
//    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
//        self.createMarkerToCoordinate(coordinate)
//    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        if let place = marker.userData as? PlaceBE {
            print("\(place.place_name) - \(place.place_address)")
        }
        
        return true
    }
}

