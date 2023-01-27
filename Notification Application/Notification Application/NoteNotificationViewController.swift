//
//  NoteNotificationViewController.swift
//  Notification Application
//
//  Created by Константин Малков on 14.12.2022.
//

import Foundation
import UIKit
import FSCalendar


class NoteNotificationViewController: UIViewController {
    
    private let calendar = FSCalendar()
    
    private let textField: UITextField = {
       let field = UITextField()
        field.placeholder = "Enter your title.."
        field.textAlignment = .left
        field.borderStyle = .roundedRect
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .continue
        field.translatesAutoresizingMaskIntoConstraints = false
        field.clearButtonMode = .whileEditing
        return field
    }()
    
    private let noteField: UITextView = {
        let field = UITextView()
        field.backgroundColor = .secondarySystemBackground
        field.textAlignment = .justified
        field.isScrollEnabled = true
        field.font = .systemFont(ofSize: 22, weight: .thin)
        field.keyboardType = .emailAddress
        return field
    }()
    
    private let placeholderLabel: UILabel = {
       let label = UILabel()
        label.text = "Notes.."
        label.sizeToFit()
        label.textColor = .tertiaryLabel
        return label
    }()
    
    private let calendarButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Detail", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private var calendarView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView = calendar
        
        setupPlaceholderLabel()
        noteField.delegate = self
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(textField)
        view.addSubview(noteField)
//        view.addSubview(calendarView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(didTapDismiss))
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let top = view.safeAreaInsets.top
        textField.frame = CGRect(x: 10, y: top+10, width: view.frame.size.width-20, height: 55)
        noteField.frame = CGRect(x: 10, y: top+15+textField.frame.size.height, width: view.frame.size.width-20, height: view.frame.size.height/4)
        calendarView.frame = CGRect(x: 10, y: 15+top+noteField.frame.size.height+textField.frame.size.height, width: view.frame.size.width-20, height: view.frame.size.height/4)
        
    }
    
    @objc private func didTapDismiss(){
        self.dismiss(animated: true)
        
    }
    
    private func setupPlaceholderLabel(){
        noteField.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (noteField.font?.pointSize)! / 2)
        placeholderLabel.isHidden = !noteField.text.isEmpty
        
    }
    
    
}

extension NoteNotificationViewController: UITextViewDelegate, FSCalendarDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !noteField.text.isEmpty
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
}
