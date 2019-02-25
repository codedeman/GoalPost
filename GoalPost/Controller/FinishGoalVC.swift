//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Kien on 2/20/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

import CoreData

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
    
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
//        if pointsTextField.text != "" {
//            self.save { (complete) in
//                if complete {
//                    dismiss(animated: true, completion: nil)
//                }
//            }
//        }
    }
    
    
    @IBAction func backWasPressed(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        dismissDetail()

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
    func textViewDidEndEditing(_ textView: UITextView) {
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
