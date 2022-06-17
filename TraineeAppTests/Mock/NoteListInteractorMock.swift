//
//  NoteListInteractorMock.swift
//  Trainee appTests
//
//  Created by Stanislav Lezovsky on 17.06.2022.
//

import Foundation
@testable import Trainee_app

final class NoteListInteractorMock: NoteListBusinessLogic {
    private(set) var didRequestInitFormCalled = false
    private(set) var didRequestDeletionCalled = false
    var fetchResponse: (() -> Void)?
    let testResponse: [NoteListCleanModel.FetchData.Response] = [
        NoteListCleanModel.FetchData.Response(
            header: "Test1",
            text: "Test1",
            date: .now,
            userShareIcon: "test image"
        ),
        NoteListCleanModel.FetchData.Response(
            header: "Test2",
            text: "Test2",
            date: .now,
            userShareIcon: "test image"
        )
    ]
    func requestDeletion(_ request: NoteListCleanModel.DeleteData.Request) {
        didRequestDeletionCalled = true
    }

    func requestInitForm(_ request: NoteListCleanModel.InitForm.Request) {
        didRequestInitFormCalled = true
    }
}
