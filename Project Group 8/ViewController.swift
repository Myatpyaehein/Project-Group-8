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
}
