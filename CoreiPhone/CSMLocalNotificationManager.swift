//
//  CSMLocalNotificationManager.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 20/03/18.
//

/*
======================================================================
Attachment   |  Supported File Types                   | Maximum Size
======================================================================
             |   kUTTypeAudioInterchangeFileFormat     |
   Audio     |   kUTTypeWaveformAudio                  |    5 MB
             |   kUTTypeMP3                            |
             |   kUTTypeMPEG4Audio                     |
----------------------------------------------------------------------
             |   kUTTypeJPEG                           |
   Image     |   kUTTypeGIF                            |    10 MB
             |   kUTTypePNG                            |
----------------------------------------------------------------------
             |   kUTTypeMPEG                           |
   Movie     |   kUTTypeMPEG2Video                     |    50 MB
             |   kUTTypeMPEG4                          |
             |   kUTTypeAVIMovie                       |
======================================================================
*/

import UIKit
import UserNotifications
import CoreLocation

public typealias CSMNotificationSuccess = () -> Void
public typealias CSMNotificationError = () -> Void

public class CSMNotificationTriggerObject: NSObject{
    
    public var trigger_timeInterval    : TimeInterval = 0
    public var tigger_repeat           = false
}

public class CSMNotificationCanlendarObject: NSObject{
    
    public var calendar_components       : DateComponents!
    public var calendar_repeat           = false
}

public class CSMAttachObject: NSObject{
    
    public var attach_name : String = ""
    public var attach_type : String = ""
    
    public func createAttachWithLocalResources() -> UNNotificationAttachment?{
        
        if let path = Bundle.main.path(forResource: self.attach_name, ofType: self.attach_type){
            
            let url = URL(fileURLWithPath: path)
            let attach = try? UNNotificationAttachment(identifier: self.attach_name, url: url, options: nil)
            return attach
        }
        
        print("Ops. Occurred an error to attach \(self.attach_name).\(self.attach_type)")
        return nil
    }
}

public class CSMNotificationObject: NSObject {
    
    public var notification_title          = ""
    public var notification_subtitle       = ""
    public var notification_message        = ""
    public var notification_identifier     = ""
    public var notification_userInfo       = [String: Any]()
    public var notification_timeInterval   : Double  = 0
    public var notification_repeat         : Bool = false
    public var notification_attachObjects  = [CSMAttachObject]()
}

public class CSMLocalNotificationManager: NSObject {
    
    public class func verifyAuthorization(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) { (granted, error) in
            
            if !granted {
             
                let title = "Local Notification Access Disabled"
                let nameApp = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
                let message = "To receive a local notification in \(nameApp) you need authorize the app in configuration section"
                let accept = "Accept"
                let cancel = "Cancel"
                let controller = UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()
        
                controller.showAlert(withTitle: title, withMessage: message, withButtons: [accept], withCancelButton: cancel, withSelectionButtonIndex: { (index) in
                    
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    
                }, withActionCancel: nil)
            }
        }
    }
    
    private class func createContentWithInformation(_ information: CSMNotificationObject) -> UNMutableNotificationContent{
        
        let content = UNMutableNotificationContent()
        content.title = information.notification_title
        content.subtitle = information.notification_subtitle
        content.body = information.notification_message
        content.userInfo = information.notification_userInfo
        
        var arrayAttach = [UNNotificationAttachment]()
        for attach in information.notification_attachObjects{
            if let obj = attach.createAttachWithLocalResources(){
                arrayAttach.append(obj)
            }
        }
        
        content.attachments = arrayAttach
        
        return content
    }
    
    public class func createNotificationWithInformation(_ information: CSMNotificationObject, withTrigger trigger: CSMNotificationTriggerObject, andOwnerDelegate delegate: UNUserNotificationCenterDelegate?, onSuccess success : CSMNotificationSuccess?, onError failure: CSMNotificationError?) {
        
        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.delegate = delegate
        
        let content = self.createContentWithInformation(information)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: trigger.trigger_timeInterval, repeats: trigger.tigger_repeat)
        let request = UNNotificationRequest.init(identifier: information.notification_identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            
            error == nil ? success?() : failure?()
        }
    }
    
    public class func createNotificationWithInformation(_ information: CSMNotificationObject, withCalendar calendar: CSMNotificationCanlendarObject, andOwnerDelegate delegate: UNUserNotificationCenterDelegate?, onSuccess success : CSMNotificationSuccess?, onError failure: CSMNotificationError?) {
        
        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.delegate = delegate
        
        let content = self.createContentWithInformation(information)
        let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.calendar_components, repeats: calendar.calendar_repeat)
        let request = UNNotificationRequest.init(identifier: information.notification_identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            
            error == nil ? success?() : failure?()
        }
    }
    
    public class func createNotificationWithInformation(_ information: CSMNotificationObject, withRegion region: CLRegion, andOwnerDelegate delegate: UNUserNotificationCenterDelegate?, onSuccess success : CSMNotificationSuccess?, onError failure: CSMNotificationError?) {
        
        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.delegate = delegate
        
        
        let content = self.createContentWithInformation(information)
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        let request = UNNotificationRequest.init(identifier: information.notification_identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            
            error == nil ? success?() : failure?()
        }
    }
    
    public class func removeNotifications(){
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    public class func removeNotificationWithIdentifier(_ identifier: String){
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    public class func removeNotificationsWithIdentifiers(_ identifiers: [String]){
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }

}
