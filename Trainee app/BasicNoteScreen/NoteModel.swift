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
        let isEmpty = (title!.isEmpty ) && (noteText!.isEmpty) // && ((date?.isEmpty) != nil)
        return isEmpty
    }
}

extension NoteModel {
    func checkEmptyNoteAndAlert(model: NoteModel, rootVC: UIViewController) {
        if model.isEmpty == true {
            rootVC.present(alert, animated: true)
        } else {
            if let encodedNote = try?
                JSONEncoder().encode(self) {
                UserDefaults.standard.set(encodedNote, forKey: "first")
            }
        }
    }
}

let alert: UIAlertController = {
    let alert = UIAlertController(
        title: "Заметка пуста!",
        message: "Невозможно сохранить пустую заметку",
        preferredStyle: .alert
    )
    let actionOK = UIAlertAction(title: "Окей", style: .default)
    alert.addAction(actionOK)
    return alert
}()
