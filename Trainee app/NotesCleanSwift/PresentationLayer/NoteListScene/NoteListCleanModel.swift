//
//  NoteListCleanModel.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//
import UIKit

enum NoteListCleanModel {
    enum InitForm {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }

    enum DeleteData {
        struct Request {
            var notesToDelete: [NoteListCleanModel.FetchData.ViewModel]
        }
        struct Response {
            var notesAfterDeletion: [NoteListCleanModel.FetchData.ViewModel]
        }
        struct ViewModel {
            var notesToPresent: [NoteListCleanModel.FetchData.ViewModel]
        }
    }

    enum FetchData {
        struct Request {}

        struct Response: Codable {
            var header: String?
            var text: String?
            var date: Date?
            var userShareIcon: String?
            var userImage: Data {
                guard let string = userShareIcon,
                      let url = URL(string: string),
                      let data = try? Data(contentsOf: url)
                else { return Data() }
                return data
            }
        }

        struct ViewModel {
            var title: String?
            var noteText: String?
            var date: Date?
            var dateToStr: String? {
                let format = "dd.MM.yyyy"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = format
                dateFormatter.locale = Locale(identifier: "ru")
                return dateFormatter.string(from: date ?? .now)
            }
            var userShareIcon: String?
            var userImage: UIImage?
            var selectionState: Bool = false
            var isEmpty: Bool {
                title!.isEmpty && noteText!.isEmpty
            }
        }
    }
}
