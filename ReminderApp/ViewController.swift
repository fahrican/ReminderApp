//
//  ViewController.swift
//  ReminderApp
//
//  Created by fahri on 12.11.18.
//  Copyright © 2018 fahri. All rights reserved.
//

import UIKit
import UserNotifications



class ViewController: UIViewController, UNUserNotificationCenterDelegate, UIActionSheetDelegate {
    
    @IBOutlet weak var labelToChangeText: UILabel!
    
    @IBOutlet weak var userInput: UITextField!
    
    @IBAction func confirm(_ sender: Any) {
        
        self.labelToChangeText.text = userInput.text
        self.userInput.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]){ (granted, error) in }
        
        UNUserNotificationCenter.current().delegate = self
        
        let content = UNMutableNotificationContent()
        content.title = "Shopping List"
        content.subtitle = "Reminder"
        content.body = "Buy Milk"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let requestId = "requestID"
        let request = UNNotificationRequest(identifier: requestId, content: content, trigger: trigger)
        
        let userNotificationCenter = UNUserNotificationCenter.current().add(request, withCompletionHandler: {(error) in })
        
        let actionSheet = UIActionSheet(title: "Action!", delegate: (self as! UIActionSheetDelegate), cancelButtonTitle: "Cancel?", destructiveButtonTitle: "OK!")
        actionSheet.actionSheetStyle = .default
        actionSheet.show(in: self.view)
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAT buttonIndex: Int) {
        
        if buttonIndex == 0 {
            
            let alertView  = UIAlertView(title: "TestView", message: "Testmessage", delegate: self, cancelButtonTitle: "OK")
            alertView.alertViewStyle = .default
            alertView.show()
        }
    }
    
    
    // This method will be called when app received push notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    
    
}

