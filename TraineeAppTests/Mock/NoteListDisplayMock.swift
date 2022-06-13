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

    func displayInitForm(_ viewModel: [NoteListCleanModel.FetchData.ViewModel]) {
        isCalledDisplayFetchedNotes = true
    }

    func presentDeletedNotes(_ response: [NoteListCleanModel.FetchData.ViewModel]) {
        isCalledDisplayDeletedNotes = true
    }
}
