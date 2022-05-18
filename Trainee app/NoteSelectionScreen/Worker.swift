//
//  Worker.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 16.05.2022.
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
        url.path = "/v0/b/ios-test-ce687.appspot.com/o/Empty.json"
        url.queryItems = [
            URLQueryItem(name: "alt", value: "media"),
            URLQueryItem(name: "token", value: "d07f7d4a-141e-4ac5-a2d2-cc936d4e6f18")
        ]
        return url.url
    }
}

private extension NoteModel {
    init(with decodedNote: DecodedNote) {
        self.init(
            title: decodedNote.header,
            noteText: decodedNote.text,
            date: decodedNote.date?.toString(format: "dd.MM.yyyy"),
            selectionState: false
        )
    }
}
