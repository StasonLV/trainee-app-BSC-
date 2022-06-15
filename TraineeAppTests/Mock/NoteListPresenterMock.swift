//
//  NoteListPresenterMock.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 13.06.2022.
//

import Foundation
@testable import Trainee_app

final class NoteListPresentationLogicMock: NoteListPresentationLogic {
    private(set) var isCalledPresentNotes = false
    private(set) var isCalledPresentDeletedNotes = false
    var responseMock: [NoteListCleanModel.FetchData.Response]?
    var responseDeletionMock: NoteListCleanModel.DeleteData.Response?
    var fetchResponse: (() -> Void)?

    func presentDeletedNotes(_ response: NoteListCleanModel.DeleteData.Response) {
        isCalledPresentDeletedNotes = true
        responseDeletionMock = response
    }

    func presentFetchedNotes(_ response: [NoteListCleanModel.FetchData.Response]) {
        isCalledPresentNotes = true
        responseMock = response
        fetchResponse?()
    }

    func presentDecodeAlert() {
        <#code#>
    }
    
    func presentConnectAlert() {
        <#code#>
    }
}
