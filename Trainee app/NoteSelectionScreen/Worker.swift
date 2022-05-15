//
//  Worker.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 14.05.2022.
//

import Foundation

protocol WorkerType {
    var session: URLSession { get }
    func fetch(completed: @escaping ([NoteModel]) -> Void)
}

class Worker: WorkerType {

    struct DecodedNote: Codable {
        var header: String?
        var text: String?
        var date: Int?
    }

    let session: URLSession

    init (session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func fetch(completed: @escaping ([NoteModel]) -> Void) {
        guard let url = createURLComponents() else {
            print("Error finding JSON File")
            return
        }
        let task = session.dataTask(with: url) { data, response, error in
            guard let onlineNotesArray = data,
                  let responses = try? JSONDecoder().decode([DecodedNote].self, from: onlineNotesArray)
            else { return }
            for response in responses {
                var tempArray = [NoteModel]()
                let date = Double(response.date ?? 0)
                let note = NoteModel(
                    title: response.header,
                    noteText: response.text,
                    date: Date(timeIntervalSince1970: date).toString(format: "dd.MM.yyy"),
                    selectionState: false)
                tempArray.append(note)
                DispatchQueue.main.async {
                    completed(tempArray)
                }
            }
        }
        task.resume()
    }

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
