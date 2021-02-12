//
//  BluetoothViewController.swift
//  SmartHm
//
//  Created by Marvin Herhaus on 03.02.21.
//

import UIKit
import CoreLocation

class BluetoothViewController: UIViewController, CLLocationManagerDelegate  {


        var locationManager: CLLocationManager?
        var lastdistance = CLProximity.unknown
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var lightLabel: UILabel!
    
    
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse{
                if CLLocationManager.isRangingAvailable(){
                    if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                        // it can start
                        startScanning()
                    }
                }
           }
        }
        
        func startScanning(){
            let uuid = UUID(uuidString: "242ED109-CF7D-46BA-98C4-61CF33799A4D")!
            let constraint = CLBeaconIdentityConstraint(uuid: uuid)
            let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: "My Beacon")
            locationManager?.startMonitoring(for: beaconRegion)
            locationManager?.startRangingBeacons(satisfying: constraint)
        }
        
        func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
            if let beacon = beacons.first{
                update(distance: beacon.proximity)
                print("Ranging \(beacon.uuid)")
            }else{
                update(distance: .unknown)
            }
        }
        
        func update(distance: CLProximity){
            lastdistance = distance
            if(distance == .far) {
                print ("Far") //Über 3 Meter
                distanceLabel.text = "Distance: Far"
                lightLabel.backgroundColor = #colorLiteral(red: 1, green: 0.9350638906, blue: 0, alpha: 1)
            }
            if(distance == .near) {
                print ("Near") //1-3 Meter
                distanceLabel.text = "Distance: Near"
                lightLabel.backgroundColor = #colorLiteral(red: 1, green: 0.9350638906, blue: 0, alpha: 0.7509950391)
            }
            if(distance == .immediate) {
                print ("HERE") //Ganz nah
                distanceLabel.text = "Distance: Here"
                lightLabel.backgroundColor = #colorLiteral(red: 1, green: 0.9350638906, blue: 0, alpha: 0.2525268347)
            }
            if(distance == .unknown) {
                print("Unknown") //zu weit weg
                distanceLabel.text = "Distance: Unknown"
                lightLabel.backgroundColor = #colorLiteral(red: 1, green: 0.926055491, blue: 0, alpha: 0.04648180073)
            }
        }
    
}
