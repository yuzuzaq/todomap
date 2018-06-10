//
//  StartViewController.swift
//  todomap
//
//  Created by 森川彩音 on 2017/11/19.
//  Copyright © 2017年 森川彩音. All rights reserved.
//

import UIKit
import CoreLocation

class viewController: UIViewController, CLLocationManagerDelegate {
    
    var myLocationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationAuthorization(callback: startLocationService)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.authorizedAlways {
            return
        }
        
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        
        startLocationService(manager: manager)
    }
    
    func checkLocationAuthorization(callback: (CLLocationManager) -> Void) {
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied {
            return
        }
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        
        if status == CLAuthorizationStatus.notDetermined {
            myLocationManager.requestAlwaysAuthorization()
        } else if !CLLocationManager.locationServicesEnabled() {
            return
        } else {
            callback(myLocationManager)
        }
    }
    
    func startLocationService(manager: CLLocationManager) {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
}







}
