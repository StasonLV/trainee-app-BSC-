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

    func editOrCreate(for id: Int?) {
        lazy var noteVC = NoteViewController()
        if let id = id {
            dataStore?.note = viewController?.notes[id]
            viewController?.notes.remove(at: id)
            noteVC.noteViewWithCellData(with: dataStore?.note ?? NoteListCleanModel.FetchData.ViewModel())
            noteVC.completion = { [weak self] viewModel in
                DispatchQueue.main.async {
                    guard let viewModel = viewModel else { return }
                    self?.viewController?.notes.insert(viewModel, at: id)
                    self?.viewController?.notesTable.reloadData()
                }
            }
        } else {
            noteVC.completion = { [weak self] viewModel in
                DispatchQueue.main.async {
                    guard let viewModel = viewModel else { return }
                    self?.viewController?.notes.append(viewModel)
                    self?.viewController?.notesTable.reloadData()
                }
            }
        }
        viewController?.navigationController?.pushViewController(noteVC, animated: true)
    }
}
