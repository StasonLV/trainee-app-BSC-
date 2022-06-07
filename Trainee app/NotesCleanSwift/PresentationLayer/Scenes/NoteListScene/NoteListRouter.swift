//
//  NoteListRouter.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import UIKit

final class NoteListRouter: NoteListRoutingLogic, NoteListDataPassing {
    weak var viewController: NoteListViewController?
    var dataStore: NoteListDataStore?

    init(dataStore: NoteListDataStore) {
        self.dataStore = dataStore
    }

    func createNewNote() {
        guard let noteVC = NoteAssembly.build() as? NoteViewController else { return }
        noteVC.completion = { [weak self] viewModel in
            DispatchQueue.main.async {
                guard let viewModel = viewModel else { return }
                self?.viewController?.notes.append(viewModel)
                self?.viewController?.notesTable.reloadData()
            }
        }
        viewController?.navigationController?.pushViewController(noteVC, animated: true)
    }

    func showNote(for id: Int) {
        dataStore?.note = viewController?.notes[id]
        viewController?.notes.remove(at: id)
        guard let noteVC = NoteAssembly.build(viewModel: dataStore?.note) as? NoteViewController else { return }
        noteVC.completion = { [weak self] viewModel in
            DispatchQueue.main.async {
                guard let viewModel = viewModel else { return }
                self?.viewController?.notes.insert(viewModel, at: id)
                self?.viewController?.notesTable.reloadData()
            }
        }
        viewController?.navigationController?.pushViewController(noteVC, animated: true)
    }
}
