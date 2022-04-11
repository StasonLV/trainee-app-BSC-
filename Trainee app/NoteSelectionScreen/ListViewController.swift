//
//  NoteSelectionViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 08.04.2022.
//

import UIKit

class ListViewController: UIViewController, MyDataSendingDelegateProtocol {

    let listView = ListView().self
    var notes = [NoteModel]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(listView)
        self.title = "Заметки"
        NoteViewController().delegate = self
    }

    override func viewWillLayoutSubviews() {
        listView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }

    func sendDatatoFirstViewController(note: NoteModel) -> NoteContainerView {
        let container = NoteContainerView()
        container.noteNameLabel.text = note.title
        container.noteTextLabel.text = note.noteText
        container.noteDateLabel.text = note.date
        notes.append(note)
        listView.stackViewForContainers.addArrangedSubview(container)
        return container
    }

    @objc func createNewNote() {
        let newNoteVC = NoteViewController()
        newNoteVC.title = "Note Pad"
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }
}
