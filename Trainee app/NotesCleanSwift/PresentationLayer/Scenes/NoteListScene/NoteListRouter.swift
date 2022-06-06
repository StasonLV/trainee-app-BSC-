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
        let noteVC = NoteAssembly.build()
        viewController?.navigationController?.pushViewController(noteVC, animated: true)
    }

    func showNote(for id: Int) {
        let noteVC = NoteAssembly.build()
        viewController?.navigationController?.pushViewController(noteVC, animated: true)
    }
}

private extension NoteListRouter {
    func passDataToNoteDetail(source: NoteListDataStore, destination: inout NoteDataStore) {
        let selectedRow = viewController?.notesTable.indexPathForSelectedRow?.row
        let selectedNote = source.notes?[selectedRow!]
        destination.note = selectedNote
    }

    func routeToNoteDetail() {
    }
}
