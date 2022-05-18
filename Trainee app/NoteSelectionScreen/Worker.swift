//
//  Worker.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 16.05.2022.
//

import Foundation

protocol WorkerType {
    var session: URLSession { get }
    func fetch(completion: @escaping ([NoteModel]) -> Void)
}

// MARK: - Структура для полученных заметок
struct DecodedNote: Codable {
    var header: String?
    var text: String?
    var date: Date?
}

final class Worker: WorkerType {
    let session: URLSession

    init (session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - метод для получения и обработки данных по url
    func fetch(completion: @escaping ([NoteModel]) -> Void) {
        guard let url = createURLComponents() else {
            print("Ошибка в адресе JSON")
            return
        }
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Ошибка ответа от сервера: \(error.localizedDescription)")
            }
            guard let data = data,
                  let arrayOfDecodedNotes = try? JSONDecoder().decode([DecodedNote].self, from: data)
            else { return }
            let arrayOfNoteModels = arrayOfDecodedNotes.map{NoteModel(with: $0)}
            completion(arrayOfNoteModels)
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
