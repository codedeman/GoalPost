//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Kien on 2/20/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

import CoreData
import UserNotifications


class FinishGoalVC: UIViewController,UITextFieldDelegate {

    @IBOutlet var pointsTextField: UITextField!
    
    @IBOutlet var createGoalBtn: UIButton!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            
            if granted{
                print("Notification access granted ")
            }
            else{
                
                print(error?.localizedDescription)
            }
        }
    
        // Do any additional setup after loading the view.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
//        let goal = Goal(context: managedContext)
//        
//        goal.goalDescription =  goalDescription
//        goal.goalType = goalType
//        var time = timePicker.date
//        let timeInterval  =  floorf(Float(time.timeIntervalSinceReferenceDate/60))*60
//        
//        time =  NSDate(timeIntervalSinceNow: TimeInterval(timeInterval)) as Date
//        let notification  = UILocalNotification()
//        
//        notification.alertTitle  = "Reminder"
//        notification.alertBody = "Don't forget to \(goalDescription)"
//        notification.fireDate = time
//        notification.soundName =  UILocalNotificationDefaultSoundName
//        
//        reminder =  Reminder(description1: description, time: time as NSDate, notification: notification)
//        
//    }
    
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
                    
                    dismiss(animated: true, completion: nil)
                }
            }
        }
        
        sheduleNotification(inSeconds: 5, completion: { success in
            
            if success{
                print("Successfully schedule notification")
            }
            else{
                print("Erro")
            }
            
        })
        
        

    }
    
    
    @IBAction func backWasPressed(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        dismissDetail()

    }
    
    func sheduleNotification(inSeconds:TimeInterval,completion:@escaping (_ Success:Bool)->()) {
         let notif = UNMutableNotificationContent()
        notif.title = "New Notification"
        notif.subtitle =  goalType!.rawValue
        notif.body = goalDescription
        
        let  notifTrigger =  UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
    
        let request =  UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
            if error != nil{
                
                print(error)
                completion(false)
                
            }
            else {
                completion(true)
            }
        })
    }
    
    
    func save(completion: (_ finished: Bool) -> ()) {
      
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            print("Successfully saved data.")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
       
    }
    private func textViewDidEndEditing(_ textView: UITextView) {
        pointsTextField.text = ""
        pointsTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
