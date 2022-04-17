//
//  NoteView.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 03.04.2022.
//

import UIKit

final class NoteView: UIView {

    struct Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 22, weight: .bold)
        static let noteFont: UIFont = .systemFont(ofSize: 14, weight: .regular)
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

    static let alert: UIAlertController = {
        let alert = UIAlertController(
            title: "Заметка пуста",
            message: "Ты не заполнил ни одного текстового поля!",
            preferredStyle: .alert
        )
        let actionOK = UIAlertAction(title: "Окей", style: .default)
        alert.addAction(actionOK)
        return alert
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMainView()
    }

// MARK: Methods
    func setupMainView() {
        addSubview(dateField)
        addSubview(noteText)
        addSubview(titleField)
        backgroundColor = .systemGray4

        NSLayoutConstraint.activate([
            titleField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dateField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            dateField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateField.heightAnchor.constraint(equalToConstant: 28),
            noteText.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            noteText.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 5),
            noteText.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            noteText.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func dateChanged() {
        dateField.text = "\(datePicker.date.toString(format: "Дата: dd MMMM yyyy"))"
    }

    func resignResponders() {
        noteText.resignFirstResponder()
        titleField.resignFirstResponder()
        dateField.resignFirstResponder()
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

extension NoteView: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        return true
    }
}
