//
//  NotePresenter.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 04.06.2022.
//

import Foundation

final class NotePresenter: NotePresentationLogic {
    weak var view: NoteDisplayLogic?

    func presentInitForm(_ response: NoteCleanModel.InitForm.Response) {
        view?.displayInitForm(NoteCleanModel.InitForm.ViewModel())
    }

    func noteFromCell() {
        }
    }
