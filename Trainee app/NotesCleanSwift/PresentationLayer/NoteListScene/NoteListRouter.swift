//
//  NoteListRouter.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import UIKit

final class NoteListRouter: NoteListRoutingLogic, NoteListDataPassing {
    weak var viewController: UIViewController?
    var dataStore: NoteListDataStore?

    init(dataStore: NoteListDataStore) {
        self.dataStore = dataStore
    }

    func editOrCreate(
        id: Int?,
        note: NoteListCleanModel.FetchData.ViewModel,
        completion: @escaping (NoteListCleanModel.FetchData.ViewModel) -> Void
    ) {
        lazy var noteVC = NoteViewController()
        if id != nil {
            dataStore?.note = note
            noteVC.noteViewWithCellData(with: dataStore?.note ?? NoteListCleanModel.FetchData.ViewModel())
            noteVC.completion = { viewModel in
                guard let viewModel = viewModel else { return }
                completion(viewModel)
            }
        } else {
            noteVC.completion = { viewModel in
                DispatchQueue.main.async {
                    guard let viewModel = viewModel else { return }
                    completion(viewModel)
                }
            }
        }
        viewController?.navigationController?.pushViewController(noteVC, animated: true)
    }
}
