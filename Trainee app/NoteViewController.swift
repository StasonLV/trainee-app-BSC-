//
//  ViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 26.03.2022.
//

import UIKit

final class NoteViewController: UIViewController, UITextFieldDelegate {
    let defaults = UserDefaults.standard

    struct Constants {
        static let titleData = "noteName"
        static let noteData = "noteText"
        static let titleFont: UIFont = .systemFont(ofSize: 22, weight: .bold)
        static let noteFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
        static let navBarTitle: String = "NotePad"
    }

    lazy var dateField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .systemGray3
        field.layer.cornerCurve = .circular
        field.layer.cornerRadius = 5
        field.placeholder = ""
        field.inputView = datePicker
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    lazy var datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .date
        date.preferredDatePickerStyle = .wheels
        date.addTarget(
            self,
            action: #selector(self.dateChanged),
            for: .allEvents
        )
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()

    lazy var titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "Name your note..."
        field.sizeToFit()
        field.textColor = UIColor.white
        field.font = Constants.titleFont
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    lazy var noteText: UITextView = {
        let text = UITextView()
        text.backgroundColor = .systemGray3
        text.layer.cornerCurve = .circular
        text.layer.cornerRadius = 5
        text.sizeToFit()
        text.isEditable = true
        text.textColor = UIColor.white
        text.font = Constants.noteFont
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        noteText.becomeFirstResponder()
        setupMainView()
        setupNavBar()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(
            touches,
            with: event
        )
    }

    func setupMainView() {
        getViewData()
        view.addSubview(dateField)
        view.addSubview(noteText)
        view.addSubview(titleField)
        view.backgroundColor = .systemGray4
        title = Constants.navBarTitle

        NSLayoutConstraint.activate([
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            noteText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            noteText.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 10),
            noteText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            noteText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dateField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            dateField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }

    @objc func dateChanged() {
        dateField.text = "\(datePicker.date)"
    }

    @objc func saveViewData() {
        resignResponders()
        defaults.set(titleField.text, forKey: Constants.titleData)
        defaults.set(noteText.text, forKey: Constants.noteData)
        print("zna4enie \(String(describing: defaults.value(forKey: "noteName")))")
        print("zna4enie \(String(describing: defaults.value(forKey: "noteText")))")
    }

    func resignResponders() {
        noteText.resignFirstResponder()
        titleField.resignFirstResponder()
    }

    func getViewData() {
        titleField.text = defaults.string(forKey: Constants.titleData)
        noteText.text = defaults.string(forKey: Constants.noteData)
    }

    func setupNavBar() {
        let saveButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.save,
            target: self,
            action: #selector(saveViewData)
        )
        navigationItem.rightBarButtonItem = saveButton
    }
}

extension NoteViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        return true
    }
}
