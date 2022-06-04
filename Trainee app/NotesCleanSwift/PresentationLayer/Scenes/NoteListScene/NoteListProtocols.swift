//
//  NoteListProtocols.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import UIKit

protocol NoteListDataPassing {
//    var dataStore: NoteListDataStore { get }
}

protocol NoteListDataStore {}

protocol NoteListBusinessLogic: AnyObject {
    func requestInitForm(_ request: NoteListCleanModel.InitForm.Request)
    func buttonMethod()
    func fetchNotesData()
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
    func didSelectRow()
}
