//
//  AddReminderViewController.swift
//  GoalPost
//
//  Created by Kien on 3/3/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class AddReminderViewController: UIViewController {
    
    var reminder:Reminder?
    var goalDescription:String = ""
    var goalType:String = ""

    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var timePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.minimumDate = NSDate() as Date
        timePicker.locale = NSLocale.current
        
        // Do any additional setup after loading the view.
    }
    func checkDate()  {
        
        if NSDate().earlierDate(timePicker.date) == timePicker.date {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        goal.goalDescription =  goalDescription
        goal.goalType = goalType
        print(goalDescription)
        var time = timePicker.date
        let timeInterval  =  floorf(Float(time.timeIntervalSinceReferenceDate/60))*60

        time =  NSDate(timeIntervalSinceNow: TimeInterval(timeInterval)) as Date
        let notification  = UILocalNotification()

        notification.alertTitle  = "Reminder"
        notification.alertBody = "Don't forget to \(goalDescription)"
        notification.fireDate = time
        notification.soundName =  UILocalNotificationDefaultSoundName
//
        reminder =  Reminder(description1: description, time: time as NSDate, notification: notification)
//
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
       
//
//            guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
//            let goal = Goal(context: managedContext)
//            goal.goalDescription =  goalDescription
//            goal.goalType = goalType
//            var time = timePicker.date
//            let timeInterval  =  floorf(Float(time.timeIntervalSinceReferenceDate/60))*60
//
//            time =  NSDate(timeIntervalSinceNow: TimeInterval(timeInterval)) as Date
//            let notification  = UILocalNotification()
//
//            notification.alertTitle  = "Reminder"
//            notification.alertBody = "Don't forget to \(goalDescription)"
//            notification.fireDate = time
//            notification.soundName =  UILocalNotificationDefaultSoundName
//
//            reminder =  Reminder(description1: description, time: time as NSDate, notification: notification)
//
//
       
        
    }
    

  

}
