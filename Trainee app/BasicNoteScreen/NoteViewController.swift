//
//  ViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 26.03.2022.
//

import UIKit

final class NoteViewController: UIViewController, UITextFieldDelegate {

    let noteView = NoteView(frame: .zero)

    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        noteView.titleField.delegate = self
        noteView.noteText.becomeFirstResponder()
        getViewData()
        setupNavBar()
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

    @objc func saveViewData() {
        noteView.resignResponders()
        let model = NoteModel(
            title: noteView.titleField.text,
            noteText: noteView.noteText.text,
            date: noteView.dateField.text
        )
        model.saveNoteOrAlert(model: model, rootVC: self)
    }

    func getViewData() {
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
        title = "Note Pad"
    }
}
