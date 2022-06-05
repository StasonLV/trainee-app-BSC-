//
//  NoteInteractor.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 04.06.2022.
//

import Foundation

final class NoteInteractor: NoteBusinessLogic, NoteDataStore {
    var note: NoteListCleanModel.FetchData.Response!
    private let presenter: NotePresentationLogic
    private let worker: NoteWorkerLogic

    init(
        presenter: NotePresentationLogic,
        worker: NoteWorkerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
    }

    func saveNote() {
    }

    func requestInitForm(_ request: NoteCleanModel.InitForm.Request) {
//        DispatchQueue.main.async {
//            worker.fetchData() {
                self.presenter.presentInitForm(NoteCleanModel.InitForm.Response())
//            }
//        }
    }
}
