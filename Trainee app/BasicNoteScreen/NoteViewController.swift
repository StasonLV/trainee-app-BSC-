//
//  ViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 26.03.2022.
//

import UIKit

protocol MyDataSendingDelegateProtocol: AnyObject {
    func sendDatatoFirstViewController (note: NoteModel) -> NoteContainerView
}

final class NoteViewController: UIViewController, UITextFieldDelegate {

    weak var delegate: MyDataSendingDelegateProtocol?
    let noteView = NoteView(frame: .zero)
    var keyboardHeight: CGFloat = 0.0

    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        noteView.titleField.delegate = self
        noteView.noteText.becomeFirstResponder()
        // getViewData()
        setupNavBar()
        notificationSetup()
        view.addSubview(noteView)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            print("rabotaet")
                let modelToBeSent = NoteModel(
                    title: noteView.titleField.text,
                    noteText: noteView.noteText.text,
                    date: noteView.dateField.text
                    )
                self.delegate?.sendDatatoFirstViewController(note: modelToBeSent)
        }
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

    func notificationSetup() {
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

    @objc func saveViewData() {
        noteView.resignResponders()
        let model = NoteModel(
            title: noteView.titleField.text,
            noteText: noteView.noteText.text,
            date: noteView.dateField.text
        )
//        notes.append(model)
        model.saveNoteOrAlert(model: model, rootVC: self)
//        print(notes)
    }

    @objc func getViewData() {
        if let decodedNote = UserDefaults.standard.object(forKey: "first") as? Data {
            if let noteData = try? JSONDecoder().decode(NoteModel.self, from: decodedNote) {
                noteView.titleField.text = noteData.title
                noteView.noteText.text = noteData.noteText
                noteView.dateField.text = noteData.date
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

    @objc func keyboardWasShown(notification: NSNotification) {
        let info = notification.userInfo
        if let keyboardRect = info?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {

            let keyboardSize = keyboardRect.size
            noteView.noteText.contentInset = UIEdgeInsets(top: 0, left: 0,
                bottom: keyboardSize.height, right: 0)
            noteView.noteText.scrollIndicatorInsets = noteView.noteText.contentInset
        }
    }
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        noteView.noteText.contentInset = UIEdgeInsets(top: 0, left: 0,
            bottom: 0, right: 0)
        noteView.noteText.scrollIndicatorInsets = noteView.noteText.contentInset
    }
}
