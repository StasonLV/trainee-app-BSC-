//
//  NoteViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 04.06.2022.
//

import UIKit

final class NoteViewController: UIViewController, UITextFieldDelegate {
    // MARK: - константы
    let noteView = NoteView(frame: .zero)
    var completion: ((NoteListCleanModel.FetchData.ViewModel?) -> Void)?
    private enum NavBarConstants {
        static let title = "Заметка"
        static let navBarButtonTitle = "Готово"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        noteView.titleField.delegate = self
        noteView.noteText.becomeFirstResponder()
        setupNavBar()
        setupNotificationsKeyboard()
        view.addSubview(noteView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let viewModel = NoteListCleanModel.FetchData.ViewModel(
            title: noteView.titleField.text,
            noteText: noteView.noteText.text,
            date: noteView.dateField.text,
            userShareIcon: nil,
            selectionState: false
        )
        completion?(viewModel)
    }

    override func viewWillLayoutSubviews() {
        noteView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }

    // MARK: - настройка навигейшн бара
    private func setupNavBar() {
        let saveButton = UIBarButtonItem(
            title: NavBarConstants.navBarButtonTitle,
            style: .done,
            target: self,
            action: #selector(saveSelector)
        )
        navigationItem.rightBarButtonItem = saveButton
        title = NavBarConstants.title
    }

    @objc private func saveSelector() {
        let viewModel = NoteListCleanModel.FetchData.ViewModel(
            title: noteView.titleField.text,
            noteText: noteView.noteText.text,
            date: noteView.dateField.text,
            userShareIcon: nil,
            selectionState: false
        )
        completion?(viewModel)
    }
}

extension NoteViewController {
    // MARK: - обсерверы для клавиаутуры
    private func setupNotificationsKeyboard() {
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(
                self,
                selector: #selector(keyboardWasShown(notification:)),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
            notificationCenter.addObserver(
                self,
                selector: #selector(keyboardWillBeHidden(notification:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
        }

    // MARK: - методы для инсета контента при открытии клавиатуры
    @objc func keyboardWasShown(notification: NSNotification) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        let info = notification.userInfo
        if let keyboardRect = info?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardSize = keyboardRect.size
            noteView.noteText.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: keyboardSize.height,
                right: 0
            )
            noteView.noteText.scrollIndicatorInsets = noteView.noteText.contentInset
        }
    }

    @objc func keyboardWillBeHidden(notification: NSNotification) {
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = .clear
        noteView.noteText.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        noteView.noteText.scrollIndicatorInsets = noteView.noteText.contentInset
    }

    // MARK: - метод обработки нажатия вне вью
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(
            touches,
            with: event
        )
    }

    func noteViewWithCellData(with model: NoteListCleanModel.FetchData.ViewModel) {
        self.noteView.titleField.text = model.title
        self.noteView.noteText.text = model.noteText
        self.noteView.dateField.text = model.date
    }
}
