//
//  NoteListProtocols.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//


protocol NoteListDataPassing {
//    var dataStore: NoteListDataStore { get }
}

protocol NoteListDataStore {}

protocol NoteListBusinessLogic {
    func requestInitForm(_ request: NoteListCleanModel.InitForm.Request)
}

protocol NoteListWorkerLogic {}

protocol NoteListPresentationLogic {
    func presentInitForm(_ response: NoteListCleanModel.InitForm.Response)
}

protocol NoteListDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: NoteListCleanModel.InitForm.ViewModel)
}

protocol NoteListRoutingLogic {}
