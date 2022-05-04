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
        title!.isEmpty && noteText!.isEmpty
    }
}

extension NoteModel {
    func saveNoteOrAlert(model: NoteModel, rootVC: UIViewController) {
        if model.isEmpty == true {
            rootVC.present(NoteView.alert, animated: true)
        }
    }
}
