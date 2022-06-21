//
//  NoteListWorkerMock.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 13.06.2022.
//

import Foundation
@testable import Trainee_app

final class NoteListWorkingMock: NoteListWorkerLogic {
    var result: Result<[NoteListCleanModel.FetchData.Response], InternalError>?
    private(set) var isCalledFetchFunc = false
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

    func fetch(completion: @escaping (Result<[NoteListCleanModel.FetchData.Response], InternalError>) -> Void) {
        isCalledFetchFunc = true
        completion(.success(testResponse))
    }
}
