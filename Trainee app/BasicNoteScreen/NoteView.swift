//
//  NoteView.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 03.04.2022.
//

import UIKit

final class NoteView: UIView {

    // MARK: - константы
    private enum TextConstants {
        static let titleFont: UIFont = .systemFont(ofSize: 24, weight: .bold)
        static let noteFont: UIFont = .systemFont(ofSize: 16, weight: .regular)
        static let dateFont: UIFont = .systemFont(ofSize: 14, weight: .medium)
        static let dateFontColor: UIColor = UIColor(
            red: 0.675,
            green: 0.675,
            blue: 0.675,
            alpha: 1
        )
    }
    private enum ViewConstants {
        static let viewBackColor: UIColor = UIColor(
            red: 0.898,
            green: 0.898,
            blue: 0.898,
            alpha: 1
        )
    }

    // MARK: - создание эл-тов вью
    lazy var dateField: UITextField = {
        let field = UITextField()
        field.font = TextConstants.dateFont
        field.backgroundColor = ViewConstants.viewBackColor
        field.textColor = TextConstants.dateFontColor
        field.isUserInteractionEnabled = false
        field.textAlignment = .center
        field.text = "Дата: \(Date().toString(format: "dd.MM.yyyy"))"
        field.inputView = datePicker
        field.isUserInteractionEnabled = false
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
        field.textColor = .none
        field.backgroundColor = ViewConstants.viewBackColor
        field.font = TextConstants.titleFont
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    lazy var noteText: UITextView = {
        let text = UITextView()
        text.backgroundColor = .clear
        text.sizeToFit()
        text.isEditable = true
        text.textColor = .none
        text.backgroundColor = ViewConstants.viewBackColor
        text.font = TextConstants.noteFont
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    // MARK: - инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupMainView()
    }

    // MARK: - сетап вью заметки
    func setupMainView() {
        addSubview(dateField)
        addSubview(noteText)
        addSubview(titleField)
        backgroundColor = ViewConstants.viewBackColor

        NSLayoutConstraint.activate([
            dateField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 21),
            dateField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dateField.heightAnchor.constraint(equalToConstant: 16),
            dateField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            titleField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleField.topAnchor.constraint(equalTo: dateField.bottomAnchor, constant: 20),
            titleField.widthAnchor.constraint(equalToConstant: 300),
            noteText.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            noteText.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 28),
            noteText.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            noteText.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - методы для формата даты и скрытия клавиатуры
    @objc func dateChanged() {
        dateField.text = "\(datePicker.date.toString(format: "dd.MM.yyyy"))"
    }

    func resignResponders() {
        noteText.resignFirstResponder()
        titleField.resignFirstResponder()
        dateField.resignFirstResponder()
    }
}

// MARK: - расширения для даты и текствью
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
