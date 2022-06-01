//
//  NoteListPresenter.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 01.06.2022.
//

import Foundation

protocol NoteListPresenter: AnyObject {
    func interactor(didRetrieveNotes notes: [CleanNoteModel.NoteModel])
    
    func interactor(didAddNote note: CleanNoteModel.NoteModel)
    
    func interactor(didDeleteNoteAtIndex index: Int)
    
}

class NoteListPresenterImplementation: NoteListPresenter {
    weak var viewController: TitlesPresenterOutput?
    
    func interactor(didRetrieveNotes notes: [CleanNoteModel.NoteModel]) {
        let titlesStrings = titles.compactMap { $0.text }
        viewController?.presenter(didRetrieveItems: titlesStrings)
    }
    
    func interactor(didFailRetrieveTitles error: Error) {
        viewController?.presenter(didFailRetrieveItems: error.localizedDescription)
    }
    
    func interactor(didAddTitle title: Title) {
        if let titleString = title.text {
            viewController?.presenter(didAddItem: titleString)
        }
    }
    
    func interactor(didDeleteTitleAtIndex index: Int) {
        viewController?.presenter(didDeleteItemAtIndex: index)
    }
    
    func interactor(didFailDeleteTitleAtIndex index: Int) {
        viewController?.presenter(didFailDeleteItemAtIndex: index, message: "Couldn't delete")
    }
    
    func interactor(didFailAddTitle error: Error) {
        viewController?.presenter(didFailAddItem: error.localizedDescription)
    }
    
    func interactor(didFindTitle title: Title) {
        if let id = title.id {
            viewController?.presenter(didObtainItemId: id)
        }
    }
}
