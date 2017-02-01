//
//  ViewController.swift
//  UE7
//
//  Created by Student on 01/02/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
@IBAction func scheduleBtn(_ sender: AnyObject) {
    let center = UNUserNotificationCenter.current();
    
    let options: UNAuthorizationOptions = [.alert, .sound]
    
    var date1 = DateComponents()
    date1.second = 60
    let trigger = UNCalendarNotificationTrigger(dateMatching: date1 ,repeats: false)
    
    center.requestAuthorization(options: options) {
        (granted, error) in
        if !granted {
            print("Something went wrong")
        }
    }
    
    center.getNotificationSettings { (settings) in
        if settings.authorizationStatus != .authorized {
            print("Notification not allowed")
        }
    }
    
    //get Current Time
    let currentDateTime = Date()
    let userCalendar = Calendar.current
    let requestComponents: Set<Calendar.Component> = [
        .hour,
        .minute
    ]
    
    let dateTimeComponents = userCalendar.dateComponents(requestComponents, from: currentDateTime)
    
    //Set Notification Content
    let content = UNMutableNotificationContent()
    content.title = "Star Wars App Notification"
    content.body = "It's \(dateTimeComponents.hour):\(dateTimeComponents.minute)) your Character is: Obi Wan Kenobi "
    
    //identifier
    let identifier = "SWLocalNotification"
    
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
    center.add(request, withCompletionHandler: { (error) in
        if error != nil {
            // Something went wrong
        }
    })
    
}

}


