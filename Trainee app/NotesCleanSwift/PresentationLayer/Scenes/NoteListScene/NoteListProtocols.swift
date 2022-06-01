//
//  NoteListProtocols.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 01.06.2022.
//

protocol NoteListDataPassing {
//    var dataStore: CounterDataStore { get }
}

protocol NoteListDataStore {}

protocol NoteListBusinessLogic {
    func requestInitForm(_ request: CleanNoteModel.InitForm.Request)
}

protocol NoteListWorkerLogic {
    func getNotesFromUserDefaults()
    func getNotesFromUrl()
}

protocol NoteListPresentationLogic {
    func presentInitForm(_ response: CleanNoteModel.InitForm.Response)
}

protocol NoteListDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: CleanNoteModel.InitForm.ViewModel)
}

protocol NoteListRoutingLogic {
    
}
