//
//  NoteListCleanModel.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//
import Foundation
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
        }

        struct ViewModel {
            var title: String?
            var noteText: String?
            var date: String?
            var userShareIcon: String?
            var selectionState: Bool = false
            var isEmpty: Bool {
                title!.isEmpty && noteText!.isEmpty
            }
        }
    }
}
