//
//  NoteListDisplaySpy.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 13.06.2022.
//

import Foundation
@testable import Trainee_app

final class NoteListDisplayLogicMock: NoteListDisplayLogic {
    private(set) var isCalledDisplayFetchedNotes = false
    private(set) var isCalledDisplayDeletedNotes = false
    private(set) var isCalledDisplayConnectionAler = false
    private(set) var isCalledDisplayDecodeAlert = false
    private(set) var viewModelOnScreen = [NoteListCleanModel.FetchData.ViewModel]()

    func displayInitForm(_ viewModel: [NoteListCleanModel.FetchData.ViewModel]) {
        isCalledDisplayFetchedNotes = true
        viewModelOnScreen = viewModel
    }

    func presentDeletedNotes(_ response: [NoteListCleanModel.FetchData.ViewModel]) {
        isCalledDisplayDeletedNotes = true
    }

    func presentConnectionAlert() {
        isCalledDisplayConnectionAler = true
    }

    func presentDecodeAlert() {
        isCalledDisplayDecodeAlert = true
    }
}
