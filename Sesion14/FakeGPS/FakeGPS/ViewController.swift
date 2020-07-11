//
//  ViewController.swift
//  FakeGPS
//
//  Created by Kenyi Rodriguez on 7/11/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    lazy var locationManager: CLLocationManager = {
       
        let location = CLLocationManager()
        location.requestAlwaysAuthorization()
        location.showsBackgroundLocationIndicator = true
        location.allowsBackgroundLocationUpdates = true
        return location
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.startUpdatingLocation()
    }
}

