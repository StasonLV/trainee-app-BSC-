//
//  NoteListWorkerTests.swift
//  Trainee appTests
//
//  Created by Stanislav Lezovsky on 16.06.2022.
//

import XCTest
@testable import Trainee_app

final class NoteListWorkerTests: XCTestCase {
    var sut: NoteListWorkerLogic!
    var interactor: NoteListInteractorMock!
    var notesArray = [NoteListCleanModel.FetchData.Response]()
    var error: Error!

    override func setUp() {
        super.setUp()
        let noteListWorker = NoteListWorker()
        let noteListInteractor = NoteListInteractorMock()

        sut = noteListWorker
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        super.tearDown()
    }

    func testsFetchWasCalled() {
        let expectation = expectation(description: "async test fetch models")
        interactor.fetchResponse = {
            XCTAssertTrue(
                self.interactor.didRequestInitFormCalled,
                "Интерактор должен вызвать воркер"
            )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
