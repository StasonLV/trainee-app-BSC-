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

    enum FetchData {
        struct Request {}
        struct FetchResponse: Codable {
            var header: String?
            var text: String?
            var date: Date?
            var userShareIcon: String?
        }
        struct Response {
            var header: String?
            var text: String?
            var date: Date?
            var userShareIcon: String?
        }

        struct ViewModel {
            var title: String?
            var noteText: String?
            var date: String?
            var userShareIcon: UIImage?
            var selectionState: Bool = false
        }
    }
}
