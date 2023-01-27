//
//  NoteNotificationViewController.swift
//  Notification Application
//
//  Created by Константин Малков on 14.12.2022.
//

import Foundation
import UIKit


protocol NewNotificationCreated: AnyObject {
    func passData(mainLabel: String, detailLabel: String, arrayIndex: Int)
}


class NoteNotificationViewController: UIViewController {
    
    weak var delegate: NewNotificationCreated?
    
    private let coreData = NotificationsDataStack.instance
    
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

    
    
    public var titleEdit = String()
    public var subtitleEdit = String()
    public var arrayIndex = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        setupPlaceholderLabel()
        noteField.delegate = self
        textField.delegate = self
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(textField)
        view.addSubview(noteField)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(didTapDismiss))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        
        editCellData(title: titleEdit, subtitle: subtitleEdit)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let top = view.safeAreaInsets.top
        textField.frame = CGRect(x: 10, y: top+10, width: view.frame.size.width-20, height: 55)
        noteField.frame = CGRect(x: 10, y: top+15+textField.frame.size.height, width: view.frame.size.width-20, height: view.frame.size.height/5)
        
    }
    @objc private func didTapSave(){
        if let text = textField.text, !text.isEmpty,let secondText = noteField.text, !secondText.isEmpty {
            delegate?.passData(mainLabel: text, detailLabel: secondText,  arrayIndex: arrayIndex)
//            coreData.saveNotificationDataEntity(data: NotificationData(Title: text, Subtitle: secondText))
            self.dismiss(animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Enter some text", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
            present(alert, animated: true)
        }
    }
    
    
    @objc private func didTapDismiss(){
        self.dismiss(animated: true)
    }
    
    private func setupPlaceholderLabel(){
        noteField.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (noteField.font?.pointSize)! / 2)
        placeholderLabel.isHidden = !noteField.text.isEmpty
        
    }
    
    public func editCellData(title: String?, subtitle: String?){
        textField.text = title
        noteField.text = subtitle
        placeholderLabel.isHidden = !noteField.text.isEmpty
    }
}
//MARK: - Extension
extension NoteNotificationViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
        placeholderLabel.isHidden = !noteField.text.isEmpty
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
