//
//  WorkerTests.swift
//  Trainee appTests
//
//  Created by Stanislav Lezovsky on 20.06.2022.
//

import XCTest
@testable import Trainee_app

final class NoteListWorkerTests: XCTestCase {
    var sut: NoteListWorkerLogic!
    var interactor: NoteListInteractorMock!
    var notesArray = [NoteListCleanModel.FetchData.Response]()
    private var jsonMock = JsonMock()
    var error: Error!

    override func setUp() {
        super.setUp()
        let noteListWorker = NoteListWorker()
        let noteListInteractor = NoteListInteractorMock()

        sut = noteListWorker
        interactor = noteListInteractor
    }

    override func tearDown() {
        sut = nil
        interactor = nil
        super.tearDown()
    }

    func testIsDecodeFailure() {
        let sessionMock = URLSessionMock(data: nil, response: nil, error: nil)
        let sut = NoteListWorker(session: sessionMock)
        sessionMock.data = jsonMock.failure
        let expeсtationFailureDecoding = expectation(description: "ошибка декода")
        sut.fetch(completion: { result in
            switch result {
            case .success(let success):
                XCTFail("Замтеки задекодировались(ошибка) \(success)")
            case .failure(let error):
                XCTAssert(error == .decodeError)
            }
            expeсtationFailureDecoding.fulfill()
        })
        wait(for: [expeсtationFailureDecoding], timeout: 1)
    }

    func testSuccess() {
        let sessionMock = URLSessionMock(data: jsonMock.success, response: nil, error: nil)
        let sut = NoteListWorker(session: sessionMock)
        let expeсtationSuccess = expectation(description: "отдана правильная заметка")
        sut.fetch { result in
            switch result {
            case .success(let success):
                XCTAssert(success[0].header == "Вторая заметка", "Значение должно быть - Вторая заметка")
            case .failure(let error):
                XCTFail("получена \(error) вместо успешной передачи")
            }
            expeсtationSuccess.fulfill()
        }
        wait(for: [expeсtationSuccess], timeout: 1)
    }

    func testNetworkFailure() {
        let sessionMock = URLSessionMock(data: nil, response: nil, error: .some(InternalError.connectionError))
        let sut = NoteListWorker(session: sessionMock)
        let expeсtationSuccess = expectation(description: "ошибка сети")
        sut.fetch { result in
            switch result {
            case .success(let success):
                XCTFail("Замтеки задекодировались(ошибка) \(success)")
            case .failure(let error):
                XCTAssert(error == .connectionError)
            }
            expeсtationSuccess.fulfill()
        }
        wait(for: [expeсtationSuccess], timeout: 1)
    }

    private class URLSessionMock: URLSession {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        var mockTask: MockTask
        init(data: Data?, response: URLResponse?, error: Error?) {
            mockTask = MockTask(data: data, response: response, error: error)
        }
        override func dataTask(
            with url: URL,
            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
        ) -> URLSessionDataTask {
            mockTask.completionHandler = completionHandler
            return mockTask
        }
    }

    private class MockTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let _error: Error?
        override var error: Error? {
            return _error
        }
        var completionHandler:(
            (Data?, URLResponse?, Error?) -> Void)!
        init(
            data: Data?, response: URLResponse?, error: Error?
        ) {
            self.data = data
            self.urlResponse = response
            self._error = error
        }
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler(self.data, self.urlResponse, self.error)
            }
        }
    }

    private struct JsonMock {
        var failure: Data? = {
            var json = """
            {
              "status": "OK",
              "content": {
                "deviceId": "123"
              }
            }
            """
            return json.data(using: .utf8)
        }()
        var success: Data? = {
            var json = """
    {
           "header": "Вторая заметка",
           "text": "Ура мы получили заметку",
           "date": 1650447457,
           "userShareIcon": "https://s.pfst.net/2018.05/64189746721079ccc03f917088c5a6c53f1240bddb75_b.jpg"
       }
    """
            return json.data(using: .utf8)
        }()
    }
}
