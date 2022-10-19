//
//  DetailViewController.swift
//  Remember2Remember
//
//  Created by Chris Boshoff on 2022/05/10.
//

import UIKit
import Photos
import AVFoundation
import UserNotifications

class DetailViewController: UIViewController {

    var update  = false
    var item    : Item!
    
    @IBOutlet weak var titleTextField   : UITextField!
    @IBOutlet weak var expDateTextField : UITextField!
    @IBOutlet weak var remindTextField  : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if update == true {
            titleTextField.text     = item.title
            expDateTextField.text   = item.expDate
            remindTextField.text    = item.remindDate
            
            self.title = "Edit"
        }
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        if titleTextField.text! != "" && expDateTextField.text! != "" && remindTextField.text! != "" {
            if update == true {
                CoreDataManager.functions.updateItem(title: titleTextField.text!, expDate: expDateTextField.text!, remindDate: remindTextField.text!, itemObject: item)
            } else {
                CoreDataManager.functions.createItem(title: titleTextField.text!, expDate: expDateTextField.text!, remindDate: remindTextField.text!)
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        if titleTextField.text! == ""  {
            showAlert(title: "Title Missing", message: "Please ensure that you document is given an appropriate title")
        }
        
        if expDateTextField.text == "" || remindTextField.text == "" {
            showAlert(title: "Date Missing", message: "Please ensure that dates are chosen for both the Expiring Date and the Reminder Date.")
        }
        
        // Setup Local Push Notification
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.sound = .default
        content.body = "Your \(titleTextField.text ?? "document") is about to expire!"
        
        let dateString = remindTextField.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let targetDate = dateFormatter.date(from: dateString)?.addingTimeInterval(32400) ?? Date()
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: targetDate) , repeats: false)
        
        let request = UNNotificationRequest(identifier: "Reminder_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("something went wrong")
            }
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                // Schedule reminder
                self.reminderTest()
            }
            else if error != nil {
                print("error")
            }
        }
    }
    
    func reminderTest() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.sound = .default
        DispatchQueue.main.async {
            content.body  = "Your \(self.titleTextField.text ?? "document") is about to expire!"
        }
        
        let dateString    = remindTextField.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let targetDate = dateFormatter.date(from: dateString)?.addingTimeInterval(32400) ?? Date()
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: targetDate) , repeats: false)
        
        let request = UNNotificationRequest(identifier: "Reminder_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                print("something went wrong")
            }
        }
    }
    
    @IBAction func expDateEdit(_ sender: Any) {
        dateSelector()

    }
    
    @IBAction func remindDateEdit(_ sender: Any) {
       reminderSelector()
    }
    
    func dateSelector() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .inline
        
        expDateTextField.inputView = datePicker
        expDateTextField.text = formatDate(date: Date())
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        expDateTextField.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    // MARK: - Reminder Date Selector
    func reminderSelector() {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(reminderChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .inline
        
        remindTextField.inputView = datePicker
        remindTextField.text = formatDate(date: Date())
 
    }
    
    @objc func reminderChange(datePicker: UIDatePicker) {
        remindTextField.text = formatDate(date: datePicker.date)
       // completion?(datePicker.date)
  
    }
    
    func formatReminder(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
    
    
    // MARK: - Alert for Empty Text Fields
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true)        
    }
}



