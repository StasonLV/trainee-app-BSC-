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
    var containerViews = [NoteContainerView]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fillStackView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(listView)
        self.title = "Заметки"
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
        containerViews.append(container)
        return container
    }

    func fillStackView () {
        for item in containerViews {
            listView.stackViewForContainers.addArrangedSubview(item)
            listView.stackViewForContainers.distribution = .equalCentering
            listView.stackViewForContainers.layoutSubviews()
        }
    }

    @objc func createNewNote() {
        let newNoteVC = NoteViewController()
        newNoteVC.delegate = self
        newNoteVC.title = "Note Pad"
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }
}
