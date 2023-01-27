//
//  SetReminderViewController.swift
//  Notification Application
//
//  Created by Константин Малков on 31.12.2022.
//

import UIKit

protocol SetReminderDelegate: AnyObject {
    func passData(notificationDate: Date)
}

class SetReminderViewController: UIViewController {
    
    weak var delegate: SetReminderDelegate?
    
    private let closeButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemBlue
        button.backgroundColor = .secondarySystemBackground
        return button
    }()
    
    private let datePicker: UIDatePicker = {
       let picker = UIDatePicker()
        picker.locale = .current
        picker.layer.cornerRadius = 8
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .inline
        picker.locale = Locale(identifier: "ru_RU")
        picker.tintColor = .systemBlue
        picker.backgroundColor = .secondarySystemBackground
        return picker
    }()
    
    private let reminderLabel: UILabel = {
       let label = UILabel()
        label.text = "Set date and time for reminder"
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        label.backgroundColor = .secondarySystemBackground
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let buttonDatePicker: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName:"calendar.badge.plus"), for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 26, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitle(" Add Date to Reminder", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        requestNotification()
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.frame = CGRect(x: view.frame.size.width-40, y: 10, width: 30, height: 30)
        closeButton.layer.cornerRadius = 0.5 * closeButton.bounds.width
        reminderLabel.frame = CGRect(x: 20, y: 30, width: view.frame.size.width-40, height: 60)
        datePicker.frame = CGRect(x: 20, y: closeButton.frame.size.height+20+reminderLabel.frame.size.height, width: view.frame.size.width-40, height: 400)
        buttonDatePicker.frame = CGRect(x: 20, y: 20+reminderLabel.frame.size.height+datePicker.frame.size.height+20, width: view.frame.size.width-40, height: 55)
    }
    
    @objc private func didTapSetReminder(){
        let date = datePicker.date
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        print("Date \(hour): \(minute)")
        delegate?.passData(notificationDate: date)
        dismiss(animated: true)
    }
    
    
    
    @objc private func didTapClose(){
        dismiss(animated: true)
    }
    
    private func requestNotification(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                
            } else if let error = error {
                print("error occurred \(error)")
            }
        }
    }
    
    private func setupView(){
        view.addSubview(closeButton)
        view.addSubview(reminderLabel)
        
        view.addSubview(datePicker)
        view.addSubview(buttonDatePicker)
        view.backgroundColor = .secondarySystemBackground
        buttonDatePicker.addTarget(self, action: #selector(didTapSetReminder), for: .touchUpInside)
    }
}
