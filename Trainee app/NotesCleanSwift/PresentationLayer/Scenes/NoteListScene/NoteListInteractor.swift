//
//  NoteListInteractor.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import Foundation
import UIKit

final class NoteListInteractor: NoteListBusinessLogic, NoteListDataStore {
    var notes: [NoteListCleanModel.FetchData.ViewModel]?
    private let presenter: NoteListPresentationLogic
    private let worker: NoteListWorkerLogic

    private(set) var model: [NoteListCleanModel.FetchData.Response]?

    init(
        presenter: NoteListPresentationLogic,
        worker: NoteListWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func requestInitForm(_ request: NoteListCleanModel.InitForm.Request) {
        worker.fetch { response in
            DispatchQueue.main.async {
                self.presenter.presentFetchedNotes(response)
            }
        }
    }
}
