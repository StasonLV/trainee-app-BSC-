//
//  Worker.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 14.05.2022.
//

import Foundation

protocol WorkerType {
    var session: URLSession { get }
    func fetch() -> [NoteModel]
    func convertToNoteModel(input: DecodedNote) -> NoteModel
}

var noteArray = [NoteModel]()

struct DecodedNote: Codable {
    var header: String?
    var text: String?
    var date: Int?
}

class Worker: WorkerType {

    let session: URLSession

    init (session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func fetch() -> [NoteModel] {
        let url = createURLComponents()!
        let task = session.dataTask(with: url) { data, response, error in
            guard let onlineNotesArray = data,
                  let responses = try? JSONDecoder().decode([DecodedNote].self, from: onlineNotesArray)
            else { return }
            for response in responses {
                let note = self.convertToNoteModel(input: response)
                noteArray.append(note)
            }
            print(noteArray)
        }
        task.resume()
        return noteArray
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

    internal func convertToNoteModel(input: DecodedNote) -> NoteModel {
        let convertedDate = Date(timeIntervalSince1970: Double(input.date!)).toString(format: "dd.MM.yyyy")
        let model = NoteModel(title: input.header, noteText: input.text, date: convertedDate, selectionState: false)
//        print(model)
        return model
    }
}
