//
//  NoteListPresenterTests.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 13.06.2022.
//

import XCTest
@testable import Trainee_app

final class NoteListPresenterTests: XCTestCase {
    private var sut: NoteListPresenter!
    private var viewController: NoteListDisplayLogicMock!
    let mockResponseFetch: [NoteListCleanModel.FetchData.Response] = [
        NoteListCleanModel.FetchData.Response(
            header: "Test1",
            text: "Test1",
            date: .now,
            userShareIcon: "testString"
        ),
        NoteListCleanModel.FetchData.Response(
            header: "Test2",
            text: "Test2",
            date: .now,
            userShareIcon: "testString"
        )
    ]
    let mockResponseDelete: NoteListCleanModel.DeleteData.Response = NoteListCleanModel.DeleteData.Response(notesAfterDeletion: [])

    override func setUp() {
        super.setUp()

        let noteListPresenter = NoteListPresenter()
        let noteListViewController = NoteListDisplayLogicMock()
        noteListPresenter.view = noteListViewController
        sut = noteListPresenter
        viewController = noteListViewController
    }

    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }

    func testPresentFetchedNotes() {
        sut.presentFetchedNotes(mockResponseFetch)
        XCTAssertTrue(
            viewController.isCalledDisplayFetchedNotes,
            "должен вызваться метод дисплей лоджик для скачанных заметок"
        )
    }

    func testPresentDeletedNotes() {
        sut.presentDeletedNotes(mockResponseDelete)
        XCTAssertTrue(
            viewController.isCalledDisplayDeletedNotes,
            "должен вызваться метод дисплей лоджик для скачанных заметок"
        )
    }
}
