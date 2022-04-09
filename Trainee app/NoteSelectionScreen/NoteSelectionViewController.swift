//
//  NoteSelectionViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 08.04.2022.
//

import UIKit

class NoteSelectionViewController: UIViewController {
    let noteSelectionView = NoteSelectionView().self

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(noteSelectionView)
        self.title = "Заметки"
    }

    override func viewWillLayoutSubviews() {
        noteSelectionView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }

    @objc func createNewNote() {
        let newNoteVC = NoteViewController()
        newNoteVC.title = "Note Pad"
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }
}
