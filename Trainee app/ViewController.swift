//
//  ViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 26.03.2022.
//

import UIKit

class ViewController: UIViewController {
    let titleField: UITextField = {
            
            let field = UITextField()
            field.text = "Title"
            field.sizeToFit()
            field.textColor = UIColor.white
            field.font = .systemFont(ofSize: 22, weight: .bold)
            field.translatesAutoresizingMaskIntoConstraints = false
            
            return field
        }()
        
        let noteText: UITextView = {
            
            let text = UITextView()
            text.text = "Type your note here..."
            text.backgroundColor = .blue
            text.sizeToFit()
            text.isEditable = true
            text.textColor = UIColor.white
            text.font = .systemFont(ofSize: 14, weight: .regular)
            text.translatesAutoresizingMaskIntoConstraints = false
            
            return text
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemGray4
            setupScrollView()
        }
                
        func setupScrollView() {
            
            view.addSubview(noteText)
            view.addSubview(titleField)
            
            NSLayoutConstraint.activate([
                
                titleField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                titleField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                noteText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                noteText.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
                noteText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                noteText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
            ])
        }
}

