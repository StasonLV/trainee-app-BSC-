//
//  ViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 26.03.2022.
//

import UIKit

protocol MyDataSendingDelegateProtocol: AnyObject {
    func sendDatatoFirstViewController (note: NoteModel)
}

final class NoteViewController: UIViewController, UITextFieldDelegate {

    weak var delegate: MyDataSendingDelegateProtocol?
    let noteView = NoteView(frame: .zero)
    var keyboardHeight: CGFloat = 0.0
    var completion: ((NoteModel) -> Void)?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        noteView.titleField.delegate = self
        noteView.noteText.becomeFirstResponder()
        setupNavBar()
        notificationSetup()
        view.addSubview(noteView)
    }

    // MARK: Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(
            touches,
            with: event
        )
    }

    override func viewWillLayoutSubviews() {
        noteView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }

    private func notificationSetup() {
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

    @objc private func saveViewData() {
        noteView.resignResponders()
        let modelToBeSent = NoteModel(
            title: noteView.titleField.text,
            noteText: noteView.noteText.text,
            date: noteView.dateField.text
            )
        self.delegate?.sendDatatoFirstViewController(note: modelToBeSent)
        modelToBeSent.saveNoteOrAlert(model: modelToBeSent, rootVC: self)
    }

    private func setupNavBar() {
        let saveButton = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(saveViewData)
        )
        navigationItem.rightBarButtonItem = saveButton
    }

    func configureNoteView (with model: NoteModel) {
        noteView.titleField.text = model.title
        noteView.noteText.text = model.noteText
        noteView.dateField.text = model.date
    }

    // MARK: Keyboard Notifications
    @objc private func keyboardWasShown(notification: NSNotification) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        let info = notification.userInfo
        if let keyboardRect = info?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {

            let keyboardSize = keyboardRect.size
            noteView.noteText.contentInset = UIEdgeInsets(top: 0, left: 0,
                bottom: keyboardSize.height, right: 0)
            noteView.noteText.scrollIndicatorInsets = noteView.noteText.contentInset
        }
    }

    @objc private func keyboardWillBeHidden(notification: NSNotification) {
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = .clear
        noteView.noteText.contentInset = UIEdgeInsets(top: 0, left: 0,
            bottom: 0, right: 0)
        noteView.noteText.scrollIndicatorInsets = noteView.noteText.contentInset
    }
}
