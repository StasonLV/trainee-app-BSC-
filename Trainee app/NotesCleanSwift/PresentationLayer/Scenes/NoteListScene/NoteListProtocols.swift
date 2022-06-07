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
    func requestDeletion(_ request: [NoteListCleanModel.DeleteData.Request])
    func requestInitForm(_ request: NoteListCleanModel.InitForm.Request)
}

protocol NoteListWorkerLogic {
    func fetch(completion: @escaping ([NoteListCleanModel.FetchData.Response]) -> Void)
}

protocol NoteListPresentationLogic {
    func presentFetchedNotes(_ response: [NoteListCleanModel.FetchData.Response])
}

protocol NoteListDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: [NoteListCleanModel.FetchData.ViewModel])
}

protocol NoteListRoutingLogic {
    func createNewNote()
    func showNote(for id: Int)
}
