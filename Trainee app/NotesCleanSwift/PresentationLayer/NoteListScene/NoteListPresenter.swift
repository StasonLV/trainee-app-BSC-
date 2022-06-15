//
//  NoteListPresenter.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//
import UIKit

final class NoteListPresenter: NoteListPresentationLogic {
    weak var view: NoteListDisplayLogic?

    func presentDeletedNotes(_ response: NoteListCleanModel.DeleteData.Response) {
        let viewModel = response.notesAfterDeletion.map {
            NoteListCleanModel.FetchData.ViewModel(
                title: $0.title,
                noteText: $0.noteText,
                date: $0.date,
                userImage: $0.userImage,
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
                date: $0.date,
                userImage: UIImage(data: $0.userImage),
                selectionState: false
            )
        }
        view?.displayInitForm(viewModel)
    }

    func presentDecodeAlert() {
        view?.presentDecodeAlert()
    }

    func presentConnectAlert() {
        view?.presentConnectionAlert()
    }
}
