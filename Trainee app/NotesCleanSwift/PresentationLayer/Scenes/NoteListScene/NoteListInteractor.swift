//
//  NoteListInteractor.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import Foundation
import UIKit

final class NoteListInteractor: NoteListBusinessLogic, NoteListDataStore {
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

    func buttonMethod() {
        print(2)
    }

    func fetchNotesData() {
        DispatchQueue.global().async {
            self.worker.fetch(completion: { response in
                self.model = response
            }
            )
        }
    }

    func requestInitForm(_ request: NoteListCleanModel.InitForm.Request) {
        print(model)
            guard let modelForPresenter = self.model else { return }
            self.presenter.presentFetchedNotes(modelForPresenter)
    }
}
