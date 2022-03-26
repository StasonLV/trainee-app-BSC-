//
//  ViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 26.03.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let saveButton: UIButton = {
        
        let button = UIButton()
            button.setTitle("Save", for: .normal)
            button.backgroundColor = .systemBrown
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self,
                             action: #selector(saveData),
                             for: .touchUpInside)
        
        return button
    }()
    
    let titleField: UITextField = {
            
            let field = UITextField()
            field.placeholder = "Name your note..."
            field.sizeToFit()
            field.textColor = UIColor.white
            field.font = .systemFont(ofSize: 22, weight: .bold)
            field.translatesAutoresizingMaskIntoConstraints = false
            
        return field
    }()
        
    let noteText: UITextView = {
            
            let text = UITextView()
            text.backgroundColor = .systemGray3
            text.layer.cornerCurve = .circular
            text.layer.cornerRadius = 5
            text.isScrollEnabled = false
            text.sizeToFit()
            text.isEditable = true
            text.textColor = UIColor.white
            text.font = .systemFont(ofSize: 14, weight: .regular)
            text.translatesAutoresizingMaskIntoConstraints = false
            
        return text
    }()
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            titleField.delegate = self
            titleField.text = TextFieldData.titleData
            noteText.text = TextFieldData.noteData
            noteText.becomeFirstResponder()
            view.backgroundColor = .systemGray4
            setupMainView()
            
    }
    
        @objc func saveData() {
            
            noteText.resignFirstResponder()
            titleField.resignFirstResponder()
            TextFieldData.titleData = titleField.text
            TextFieldData.noteData = noteText.text
            
    }
                
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            view.endEditing(true)
            super.touchesBegan(touches, with : event)
            
    }
    
        func setupMainView() {
            
            view.addSubview(noteText)
            view.addSubview(titleField)
            view.addSubview(saveButton)
            
            NSLayoutConstraint.activate([
                titleField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                titleField.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
                titleField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                noteText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                noteText.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
                noteText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                saveButton.heightAnchor.constraint(equalToConstant: 20),
                saveButton.widthAnchor.constraint(equalToConstant: 70)                
        ])
    }
}

extension ViewController: UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        
        return true
    }
}
