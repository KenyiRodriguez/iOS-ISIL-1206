//
//  CSMLocationManager.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 15/03/18.
//

import UIKit
import CoreLocation

public enum CSMTypeRequestAuthorization {

    case whenInUse
    case always
}


@objc public protocol CSMLocationManagerDelegate: NSObjectProtocol {
    
    @objc optional func locationManager(_ manager: CSMLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    @objc optional func locationManager(_ manager: CSMLocationManager, didUpdateLocation userLocation: CLLocation?)
}

@objc public protocol CSMLocationManagerRegionDelegate: NSObjectProtocol {

    @objc optional func locationManager(_ manager: CSMLocationManager, userUpdateLocation userLocation: CLLocation?, createRegions arrayRegions: @escaping (_ array: [CSMCircularRegion]) -> Void)
    @objc optional func locationManager(_ manager: CSMLocationManager, createNotificationInformationForRegion region: CSMCircularRegion, withObject object: Any?) -> CSMNotificationObject
    @objc optional func locationManager(_ manager: CSMLocationManager, didEnterRegion region: CSMCircularRegion)
    @objc optional func locationManager(_ manager: CSMLocationManager, didExitRegion region: CSMCircularRegion)
}

public class CSMCircularRegion: NSObject{
    
    public var identifier       = ""
    public var radius           : CLLocationDistance = 0.0
    public var center           : CLLocationCoordinate2D!
    public var objectReference  : Any?
    public var notifyOnEntry    = true
    public var notifyOnExit     = false
    var region                  : CLCircularRegion!
    
    public init(center: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, object: Any?){
        
        self.identifier = identifier
        self.center = center
        self.radius = radius
        self.objectReference = object
        self.region = CLCircularRegion(center: center, radius: radius, identifier: identifier)
        self.region.notifyOnEntry = self.notifyOnEntry
        self.region.notifyOnExit = self.notifyOnExit
    }
    
}

public class CSMLocationManager: NSObject, CLLocationManagerDelegate {

    public static let sharedInstance    = CSMLocationManager()
    public var arrayCircularRegions     = [CSMCircularRegion]()
    public var userLocation             : CLLocation?
    public var delegate                 : CSMLocationManagerDelegate?
    public var delegateRegion           : CSMLocationManagerRegionDelegate?
    
    public var distanceFilter : CLLocationDistance = 500{
        didSet{
            self.locationManager.distanceFilter = self.distanceFilter
        }
    }
    
    lazy public var locationManager : CLLocationManager = {
        
        let _locationManager = CLLocationManager()
        
        _locationManager.distanceFilter = self.distanceFilter
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.delegate = self
        _locationManager.allowsBackgroundLocationUpdates = self.getBackgroundModeAuthorization()
        
        return _locationManager
    }()
    
    public func updateRegionsToMonitoriong(){
     
        self.delegate?.locationManager?(self, didUpdateLocation: self.userLocation)
        
        self.delegateRegion?.locationManager?(self, userUpdateLocation: self.userLocation, createRegions: { (arrayCircularRegions) in
            
            self.arrayCircularRegions = arrayCircularRegions
            self.createNewRegions()
        })
    }
    
    public func getDistanceToLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> CLLocationDistance{
     
        let location = CLLocation(latitude: latitude, longitude: longitude)
        return self.userLocation?.distance(from: location) ?? 0
    }
    
    public func startLocation(withRequestAthorization requestAuthorization: CSMTypeRequestAuthorization){
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if  authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        }else if authorizationStatus == .denied{
            self.showAlertToChangeAuthorization()
        }else{
            requestAuthorization == .always ? self.locationManager.requestAlwaysAuthorization() : self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            
            self.locationManager.startUpdatingLocation()
        }else if status == .denied {
            self.showAlertToChangeAuthorization()
        }
        
        self.delegate?.locationManager?(self, didChangeAuthorization: status)
    }
    
    private func showAlertToChangeAuthorization(){
        
        let title = "Location Access Disabled"
        let nameApp = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        let message = "To use your current location in \(nameApp) you would setup this in app configuration section"
        let accept = "Accept"
        let cancel = "Cancel"
        let controller = UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()
        
        controller.showAlert(withTitle: title, withMessage: message, withButtons: [accept], withCancelButton: cancel, withSelectionButtonIndex: { (index) in
            
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            
        }, withActionCancel: nil)
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.userLocation = locations.first
        self.removeRegions()
        self.updateRegionsToMonitoriong()
    }
    
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        if let regionCustom = self.getRegionByIdentifier(region.identifier){
            self.delegateRegion?.locationManager?(self, didEnterRegion: regionCustom)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        if let regionCustom = self.getRegionByIdentifier(region.identifier){
            self.delegateRegion?.locationManager?(self, didExitRegion: regionCustom)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        print("\(region.identifier) now is monitoring")
    }
    
    private func createNewRegions(){
    
        for region in self.arrayCircularRegions{
            self.locationManager.startMonitoring(for: region.region)
            
            if let information = self.delegateRegion?.locationManager?(self, createNotificationInformationForRegion: region, withObject: region.objectReference){
                CSMLocalNotificationManager.createNotificationWithInformation(information, withRegion: region.region, andOwnerDelegate: nil, onSuccess: nil, onError: nil)
            }
        }
    }
    
    private func removeRegions(){
        
        for region in self.locationManager.monitoredRegions{
            
            CSMLocalNotificationManager.removeNotificationWithIdentifier(region.identifier)
            self.locationManager.stopMonitoring(for: region)
        }
        
        self.arrayCircularRegions.removeAll()
    }
    
    private func getRegionByIdentifier(_ identifier: String) -> CSMCircularRegion?{
        
        let arrayResult = self.arrayCircularRegions.filter({$0.identifier == identifier})
        return arrayResult.first
    }
    
    private func getBackgroundModeAuthorization() -> Bool{
        
        let backgroundModes = Bundle.main.infoDictionary?["UIBackgroundModes"] as? [String]
        return backgroundModes?.contains(where: {$0 == "location"}) ?? false
    }
}
