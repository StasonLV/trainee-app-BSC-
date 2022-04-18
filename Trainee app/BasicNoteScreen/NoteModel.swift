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
    var isEmpty: Bool {
        let isEmpty = (title!.isEmpty ) && (noteText!.isEmpty)
        return isEmpty
    }
}

extension NoteModel {
    func saveNoteOrAlert(model: NoteModel, rootVC: UIViewController) {
        if model.isEmpty == true {
            rootVC.present(NoteView.alert, animated: true)
        } else {
            if let encodedNote = try?
                JSONEncoder().encode(self) {
                UserDefaults.standard.set(encodedNote, forKey: "first")
            }
        }
    }
}
