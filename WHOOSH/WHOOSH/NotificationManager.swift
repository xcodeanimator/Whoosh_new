//
//  NotificationManager.swift
//  localNotification
//
//  Created by Aishwarya LED on 22/08/17.
//  Copyright © 2017 Aishwarya LED. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
var datesarr: [Date] = [Date]()
@available(iOS 10.0, *)
class NotificationManager: NSObject {
           var newcomponent = DateComponents()
     let content = UNMutableNotificationContent()
    static let shared:NotificationManager = {
        return NotificationManager()
    }()
    var isauthorized = false
    
    func reqauthorization(){
     
        let options:UNAuthorizationOptions = [.alert,.badge,.sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options){(granted:Bool, error:Error?) in
            if granted{
                print("notification authorized")
                self.isauthorized = true
            }else{
                 print("notification not authorized")
                self.isauthorized = false
            }
        }
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
 
       func called(date:Date){
        
    }
    
    func getAllPendingNotification(completion: @escaping ([UNNotificationRequest]?) -> Void){
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            return completion(requests)
            }
    }
    
    func cancelallnotification(){
        getAllPendingNotification { (requests:[UNNotificationRequest]?) in
            
            if let requestsIds = requests{
                
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: requestsIds.map{$0.identifier})
            }
           }
    }
}
@available(iOS 10.0, *)
extension NotificationManager: UNUserNotificationCenterDelegate{
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
        print("local notification recieve while app is open",notification.request.content)
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

    print("did tap on notification", response.notification.request.content)
        completionHandler()
    
    }
}

extension Date{
    
    var formattedDate:String{
        let format = DateFormatter()
        format.timeZone = TimeZone.current
        format.timeStyle = .medium
        format.dateStyle = .medium
        return format.string(from: self)
    }
    
}
