//
//  NoteListProtocols.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import UIKit

protocol NoteListDataPassing {
    var dataStore: NoteListDataStore? { get }
}

protocol NoteListDataStore {
    var note: NoteListCleanModel.FetchData.ViewModel? { get set }
}

protocol NoteListBusinessLogic: AnyObject {
    func requestDeletion(_ request: NoteListCleanModel.DeleteData.Request)
    func requestInitForm(_ request: NoteListCleanModel.InitForm.Request)
}

protocol NoteListWorkerLogic {
    func fetch(completion: @escaping (Result<[NoteListCleanModel.FetchData.Response], InternalError>) -> Void)
}

protocol NoteListPresentationLogic {
    func presentDeletedNotes(_ response: NoteListCleanModel.DeleteData.Response)
    func presentFetchedNotes(_ response: [NoteListCleanModel.FetchData.Response])
    func presentDecodeAlert()
    func presentConnectAlert()
}

protocol NoteListDisplayLogic: AnyObject {
    func presentDeletedNotes(_ response: [NoteListCleanModel.FetchData.ViewModel])
    func displayInitForm(_ viewModel: [NoteListCleanModel.FetchData.ViewModel])
    func presentConnectionAlert()
    func presentDecodeAlert()
}

protocol NoteListRoutingLogic {
    func editOrCreate(
        id: Int?,
        note: NoteListCleanModel.FetchData.ViewModel,
        completion: @escaping (NoteListCleanModel.FetchData.ViewModel) -> Void
    )
}
