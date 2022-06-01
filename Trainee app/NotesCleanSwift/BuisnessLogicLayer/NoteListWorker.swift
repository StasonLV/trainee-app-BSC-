//
//  NoteListWorker.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 01.06.2022.
//

import Foundation

protocol WorkerType {
    var session: URLSession { get }
    func fetch(completion: @escaping (Result<[NoteModel], InternalError>) -> Void)
}

// MARK: - Структура для полученных заметок
struct DecodedNote: Codable {
    var header: String?
    var text: String?
    var date: Date?
    var userShareIcon: String?
}

enum InternalError: Error {
    case URLError
    case connectionError
    case decodeError
}

final class Worker: WorkerType {
    let session: URLSession

    init (session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - метод для получения и обработки данных по url
    func fetch(completion: @escaping (Result<[NoteModel], InternalError>) -> Void) {
        guard let url = createURLComponents() else {
            completion(.failure(.URLError))
            return
        }
        let task = session.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(.connectionError))
                return
            }
            guard let data = data,
                  let notes = try? JSONDecoder().decode([DecodedNote].self, from: data)
            else {
                completion(.failure(.decodeError))
                return
            }
            let decodedNotes = notes.map { NoteModel(with: $0) }
            completion(.success(decodedNotes))
        }
        task.resume()
    }

    // MARK: - метод для удобной работы с url
    private func createURLComponents () -> URL? {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "firebasestorage.googleapis.com"
        url.path = "/v0/b/ios-test-ce687.appspot.com/o/lesson8.json"
        url.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "215055df-172d-4b98-95a0-b353caca1424")
        ]
        return url.url
    }
}
