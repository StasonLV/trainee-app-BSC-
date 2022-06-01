//
//  NoteProtocols.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 01.06.2022.
//

protocol NoteDetailsDataPassing {
//    var dataStore: CounterDataStore { get }
}

protocol NoteDetailsDataStore {}

protocol NoteDetailsBusinessLogic {
    func requestInitForm(_ request: CleanNoteModel.InitForm.Request)
}

protocol NoteDetailsWorkerLogic {
    func getNotesFromUserDefaults()
    func getNotesFromUrl()
}

protocol NoteDetailsPresentationLogic {
    func presentInitForm(_ response: CleanNoteModel.InitForm.Response)
}

protocol NoteDetailsDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: CleanNoteModel.InitForm.ViewModel)
}

protocol NoteDetailsRoutingLogic {
    
}
