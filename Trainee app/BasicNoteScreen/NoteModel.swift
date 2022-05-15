//
//  NoteModel.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 31.03.2022.
//

import Foundation
import UIKit

struct NoteModel: Codable {

    var title: String?
    var noteText: String?
    var date: String?
    var selectionState: Bool = false
    var isEmpty: Bool {
        title!.isEmpty && noteText!.isEmpty
    }

    mutating func selectionStateToggle() {
        self.selectionState.toggle()
    }
}

extension NoteModel {
    func saveNoteOrAlert(model: NoteModel, rootVC: UIViewController) {
        if model.isEmpty {
            rootVC.present(NoteView.alert, animated: true)
        }
    }
}
