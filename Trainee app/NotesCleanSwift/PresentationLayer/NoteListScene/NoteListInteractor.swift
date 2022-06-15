//
//  NoteListInteractor.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import UIKit

final class NoteListInteractor: NoteListBusinessLogic, NoteListDataStore {
    var note: NoteListCleanModel.FetchData.ViewModel?
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

    func requestDeletion(_ request: NoteListCleanModel.DeleteData.Request) {
        var notesToDelete = request.notesToDelete
        notesToDelete.removeAll { $0.selectionState == true }
        presenter.presentDeletedNotes(NoteListCleanModel.DeleteData.Response(notesAfterDeletion: notesToDelete))
    }

    func requestInitForm(_ request: NoteListCleanModel.InitForm.Request) {
        worker.fetch { [weak self] response in
            switch response {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.presenter.presentFetchedNotes(response)
                }
            case .failure(.connectionError):
                print("error")
            case .failure(.decodeError):
                print("decError")
            }
        }
    }

    func downloadImage(url: String?, handler: @escaping((_ image: UIImage) -> Void)) {
        guard let url = URL(string: url!) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            handler(image)
        }
    }
}
