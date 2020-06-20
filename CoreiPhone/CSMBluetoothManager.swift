//
//  CSMBluetoothManager.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 5/28/19.
//

import UIKit
import CoreBluetooth

public class CSMBluetoothManager: NSObject {

    public static let shared = CSMBluetoothManager()
    
    private lazy var bluetoothManager : CBCentralManager = {
       
        let opts = [CBCentralManagerOptionShowPowerAlertKey: true]
        let manager = CBCentralManager(delegate: self, queue: DispatchQueue.main, options: opts)
        return manager
    }()
    
    public func startMonitoring() {
        self.centralManagerDidUpdateState(self.bluetoothManager)
    }
}

extension CSMBluetoothManager: CBCentralManagerDelegate {
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
        case .resetting:
            self.createAlertWithMessage("The connection with the system service was momentarily lost, update imminent.")
        case .unsupported:
            self.createAlertWithMessage("The platform doesn't support Bluetooth with low energy.")
        case .unauthorized:
            self.createAlertWithMessage("The app is not authorized to use Bluetooth with low energy.", withState: .unauthorized)
        case .poweredOff:
            self.createAlertWithMessage("Bluetooth is currently powered off , powered ON first.", withState: .poweredOff)
        default:
            return
        }
    }

    private func createAlertWithMessage(_ message: String, withState state: CBManagerState = .poweredOn) {
        
        let title = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        let accept = "Accept"
        let cancel = "Cancel"
        let controller = UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()
        
        if state == .unauthorized || state == .poweredOff {
            controller.showAlert(withTitle: title, withMessage: message, withButtons: [accept], withCancelButton: cancel, withSelectionButtonIndex: { (index) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }, withActionCancel: nil)
        }else{
            controller.showAlert(withTitle: title, withMessage: message, withAcceptButton: accept, withCompletion: nil)
        }
    }
}
