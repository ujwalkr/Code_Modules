//
//  ICLocationManager.swift
//  MOH
//
//  Created by Ujwal K Raikar on 11/07/19.
//

import Foundation
import UIKit
import CoreLocation

class ICLocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager
    var completionHandler: ((CLLocation) -> Void)?
    
    override init(){
        locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
    }
    
    func getLocation(completionHandler: @escaping (CLLocation) -> Void) {
        self.completionHandler = completionHandler
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()
        //5
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completionHandler?(location)
    }
    
}


