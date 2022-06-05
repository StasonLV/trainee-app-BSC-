//
//  NoteProtocols.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 04.06.2022.
//

import Foundation

protocol NoteDataPassing {
    var dataStore: NoteDataStore { get }
}

protocol NoteDataStore {
    var note: NoteListCleanModel.FetchData.ViewModel! { get set }
}

protocol NoteBusinessLogic {
    func requestInitForm(_ request: NoteCleanModel.InitForm.Request)
    func saveNote()
}

protocol NoteWorkerLogic {
}

protocol NotePresentationLogic {
    func presentInitForm(_ response: NoteCleanModel.InitForm.Response)
}

protocol NoteDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: NoteCleanModel.InitForm.ViewModel)
}

protocol NoteRoutingLogic {}
