//
//  ViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 26.03.2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
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
            title = "NotePad"
            titleField.delegate = self
            getNoteData()
            noteText.becomeFirstResponder()
            view.backgroundColor = .systemGray4
            setupMainView()
            let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save,
                                             target: self,
                                             action: #selector(saveNoteData))
            navigationItem.rightBarButtonItem = saveButton
            
    }
                
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            view.endEditing(true)
            super.touchesBegan(touches, with : event)
            
    }
    
        func setupMainView() {
            
            view.addSubview(noteText)
            view.addSubview(titleField)
            
            NSLayoutConstraint.activate([
                titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                titleField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                noteText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                noteText.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
                noteText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
        ])
    }
    
    let defaults = UserDefaults.standard
    
    enum noteDataKeys {
        
        static let titleData = "noteName"
        static let noteData = "noteText"
    }
    
    @objc func saveNoteData() {
        
        noteText.resignFirstResponder()
        titleField.resignFirstResponder()
        defaults.set(titleField.text, forKey: noteDataKeys.titleData)
        defaults.set(noteText.text, forKey: noteDataKeys.noteData)
        print("zna4enie \(String(describing: defaults.value(forKey: "noteName")))")
        print("zna4enie \(String(describing: defaults.value(forKey: "noteText")))")
    }
    
    func getNoteData() {
        titleField.text = defaults.string(forKey: noteDataKeys.titleData)
        noteText.text = defaults.string(forKey: noteDataKeys.noteData)
    }
    
}

extension ViewController: UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        
        return true
    }
}
