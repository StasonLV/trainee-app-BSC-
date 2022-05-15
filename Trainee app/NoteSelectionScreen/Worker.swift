//
//  Worker.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 14.05.2022.
//

import Foundation

protocol WorkerType {
    var session: URLSession { get }
    func fetch()
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

    func fetch() {
        guard let url = createURLComponents() else {
            print("Error finding JSON File")
            return
          }
        do {

        } catch  {
            
        }
//        let url = createURLComponents()!
//        let task = session.dataTask(with: url) { data, response, error in
//            guard let onlineNotesArray = data,
//                  let responses = try? JSONDecoder().decode([DecodedNote].self, from: onlineNotesArray)
//            else { return }
//                DispatchQueue.main.async {
//                    for response in responses {
//                    let title = (response.header ?? "") as String
//                    let text = (response.text ?? "") as String
//                    let date = Date(timeIntervalSince1970: Double(response.date!)).toString(format: "dd.MM.yyyy")
//                    let note = NoteModel(title: title, noteText: text, date: date, selectionState: false)
//                    ListViewController().notes.append(note)
//                    ListViewController().notesTable.reloadData()
//                }
//            }
//        }
//        task.resume()
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
