//
//  NoteListInteractorTests.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 13.06.2022.
//

import XCTest
@testable import Trainee_app

final class HomeInteractorTests: XCTestCase {
    private var sut: NoteListInteractor!
    private var worker: NoteListWorkingMock!
    private var presenter: NoteListPresentationLogicMock!

    override func setUp() {
        super.setUp()

        let noteListWorker = NoteListWorkingMock()
        let noteListPresenter = NoteListPresentationLogicMock()
        let noteListInteractor = NoteListInteractor(presenter: noteListPresenter, worker: noteListWorker)
        sut = noteListInteractor
        worker = noteListWorker
        presenter = noteListPresenter
    }

    override func tearDown() {
        sut = nil
        worker = nil
        presenter = nil
        super.tearDown()
    }

    func testRequestInitForm() {
        let request = NoteListCleanModel.InitForm.Request()
        sut.requestInitForm(request)
        XCTAssertTrue(worker.isCalledFetchFunc, "Не вызыван метод воркера")
    }

    func testPresenterWasCalled() {
        let expectation = expectation(description: "async test")
        let request = NoteListCleanModel.InitForm.Request()

        presenter.fetchResponse = {
            XCTAssert(self.presenter.isCalledPresentNotes, "должен вызываться презентер")
            expectation.fulfill()
        }
        sut.requestInitForm(request)
        wait(for: [expectation], timeout: 1.0)
    }

    func testNormalResponse(_ request: NoteListCleanModel.InitForm.Request) {
        let request = NoteListCleanModel.InitForm.Request()
        worker.result = .success(worker.testResponse)
        let expectation = XCTestExpectation(description: "ждем заметки")
        sut.requestInitForm(request)
        DispatchQueue.main.async {
            XCTAssertTrue(
                self.worker.isCalledFetchFunc,
                "Метод получения погоды должен быть вызыван, ждем флаг true"
            )
            XCTAssertTrue(
                self.presenter.isCalledPresentNotes,
                "Получили город. Ждем флаг true"
            )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testDecodeErrorResponse(_ request: NoteListCleanModel.InitForm.Request) {
        let request = NoteListCleanModel.InitForm.Request()
        worker.result = .failure(.connectionError)
        let expectation = XCTestExpectation(description: "ждем заметки")
        sut.requestInitForm(request)
        DispatchQueue.main.async {
            XCTAssertTrue(
                self.presenter.isCalledNetworkAlert,
                "ошибка в соединении с сетью -> презентим алерт коннекта"
            )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testNetworkErrorResponse(_ request: NoteListCleanModel.InitForm.Request) {
        let request = NoteListCleanModel.InitForm.Request()
        worker.result = .failure(.decodeError)
        let expectation = XCTestExpectation(description: "ждем заметки")
        sut.requestInitForm(request)
        DispatchQueue.main.async {
            XCTAssertTrue(
                self.presenter.isCalledDecodeAlert,
                "ошибка в декоде -> презентим алерт декода"
            )
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testRequestDeletion() {
        let request = NoteListCleanModel.DeleteData.Request(notesToDelete: [NoteListCleanModel.FetchData.ViewModel]())
        sut.requestDeletion(request)
        XCTAssertTrue(presenter.isCalledPresentDeletedNotes, "должен вызваться метод удаления в презентере")
    }
}
