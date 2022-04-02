//
//  ViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 26.03.2022.
//

import UIKit

final class NoteViewController: UIViewController, UITextFieldDelegate {
    struct Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 22, weight: .bold)
        static let noteFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
        static let navBarTitle: String = "NotePad"
        static let cornerRadius: CGFloat = 5
    }

    lazy var dateField: UITextField = {
        let field = UITextField()
        field.font = Constants.noteFont
        field.sizeToFit()
        field.backgroundColor = .systemGray3
        field.layer.cornerCurve = .circular
        field.layer.cornerRadius = Constants.cornerRadius
        field.placeholder = Date().toString(format: "Дата: dd MMMM yyyy")
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
        text.layer.cornerRadius = Constants.cornerRadius
        text.sizeToFit()
        text.isEditable = true
        text.textColor = UIColor.white
        text.font = Constants.noteFont
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
// MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.delegate = self
        noteText.becomeFirstResponder()
        setupMainView()
        setupNavBar()
    }
// MARK: Methods
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
            titleField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            noteText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            noteText.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 5),
            noteText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            noteText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            dateField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            dateField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateField.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    @objc func dateChanged() {
        dateField.text = "\(datePicker.date.toString(format: "Дата: dd MMMM yyyy"))"
    }

    @objc func saveViewData() {
        resignResponders()
        let model = NoteModel(title: titleField.text, noteText: noteText.text, date: dateField.text)
        model.checkEmptyNoteAndAlert(model: model, rootVC: self)
    }

    func resignResponders() {
        noteText.resignFirstResponder()
        titleField.resignFirstResponder()
        dateField.resignFirstResponder()
    }

    func getViewData() {
        if let decodedNote = UserDefaults.standard.object(forKey: "first") as? Data {
            if let noteData = try? JSONDecoder().decode(NoteModel.self, from: decodedNote) {
                titleField.text = noteData.title
                noteText.text = noteData.noteText
                dateField.text = noteData.date
            }
        }
    }

    func setupNavBar() {
        let saveButton = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(saveViewData)
        )
        navigationItem.rightBarButtonItem = saveButton
    }
}
// MARK: Extensions
extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru")
        return dateFormatter.string(from: self)
    }
}

extension NoteViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        return true
    }
 }
