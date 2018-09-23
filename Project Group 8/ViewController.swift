//
//  ViewController.swift
//  Project Group 8
//
//  Created by Group 8 on 9/19/18.
//  Copyright © 2018 Myat Hein. All rights reserved.
//

import UIKit
import UserNotifications
import MapKit
import Photos
import PhotosUI
import CloudKit

class ViewController: UIViewController {

    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationService()
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
    }
    
    @IBAction func Notification(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Hello world!"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "Greeting", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    private func locationService() {
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse{
            beginLocationUpdates(locationManager: locationManager)
            
        }
    }
    
    private func beginLocationUpdates(locationManager: CLLocationManager) {
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(zoomRegion, animated: true)
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get latest location")
        
        guard let latestLocation = locations.first else {return }
        if currentLocation == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
        }
        currentLocation = latestLocation.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("The status changed")
    }
}
