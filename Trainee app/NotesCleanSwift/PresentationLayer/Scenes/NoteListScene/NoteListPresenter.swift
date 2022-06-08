//
//  NoteListPresenter.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//
import Foundation
import UIKit

final class NoteListPresenter: NoteListPresentationLogic {
    weak var view: NoteListDisplayLogic?

    func presentDeletedNotes(_ response: NoteListCleanModel.DeleteData.Response) {
        let viewModel = response.notesAfterDeletion.map {
            NoteListCleanModel.FetchData.ViewModel(
                title: $0.title,
                noteText: $0.noteText,
                date: $0.date,
                userShareIcon: $0.userShareIcon,
                selectionState: false
            )
        }
        view?.presentDeletedNotes(viewModel)
    }

    func presentFetchedNotes(_ response: [NoteListCleanModel.FetchData.Response]) {
        let viewModel = response.map {
            NoteListCleanModel.FetchData.ViewModel(
                title: $0.header,
                noteText: $0.text,
                date: $0.date?.toString(format: "dd.MM.yyyy"),
                userShareIcon: $0.userShareIcon,
                selectionState: false
            )
        }
        view?.displayInitForm(viewModel)
    }
}

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru")
        return dateFormatter.string(from: self)
    }
}
