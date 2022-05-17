//
//  Worker.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 16.05.2022.
//

import Foundation

protocol WorkerType {
    var session: URLSession { get }
    func fetch(completion: @escaping (NoteModel) -> Void)
}

final class Worker: WorkerType {

    // MARK: - Структура для полученных заметок
    struct DecodedNote: Codable {
        var header: String?
        var text: String?
        var date: Date?
    }

    let session: URLSession

    init (session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    // MARK: - метод для получения и обработки данных по url
    func fetch(completion: @escaping (NoteModel) -> Void) {
        guard let url = createURLComponents() else {
            print("Ошибка в адресе JSON")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            guard let onlineNotesArray = data,
                  let responses = try? JSONDecoder().decode([DecodedNote].self, from: onlineNotesArray)
            else { return }
                for response in responses {
                    let note = NoteModel(
                        title: response.header,
                        noteText: response.text,
                        date: response.date?.toString(format: "dd.MM.yyy"),
                        selectionState: false
                    )
                    DispatchQueue.main.async {
                        completion(note)
                    }
                }
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
