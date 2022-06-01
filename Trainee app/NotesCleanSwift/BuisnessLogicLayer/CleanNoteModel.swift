//
//  NoteModel.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 01.06.2022.
//

import Foundation

struct NoteModel: Codable {
    var title: String?
    var noteText: String?
    var date: String?
    var userShareIcon: String?
    var selectionState: Bool = false
    var isEmpty: Bool {
        title!.isEmpty && noteText!.isEmpty
    }
}
