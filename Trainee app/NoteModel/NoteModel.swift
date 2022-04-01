//
//  NoteModel.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 31.03.2022.
//

import Foundation
import UIKit

let defaults = UserDefaults.standard

struct NoteModel {
    var title: String?
    var noteText: String?
    var date: String?
    var isEmpty: Bool {
        let isEmpty = (title!.isEmpty ) && (noteText!.isEmpty) // || ((date?.isEmpty) != nil)
        return isEmpty
    }
}

extension NoteModel {
    func checkEmptyNote(model: NoteModel) {
        if model.isEmpty == true {
            simpleAlert(controller: NoteViewController())
        } else {
            print("ne pusto")
        }
    }
}

func simpleAlert(controller: NoteViewController) {
    let alert = UIAlertController(title: "Пустое поле", message: "Введите заголовок, дату или текст заметки",
                                  preferredStyle: .alert)
    let actionOK = UIAlertAction(title: "OK", style: .default)
    alert.addAction(actionOK)
    controller.present(alert, animated: true)
}

/*let alert: UIAlertController = {
    let alert = UIAlertController(title: "Пустое поле", message: "Введите заголовок, дату или текст заметки",
                                  preferredStyle: .alert)
    let actionOK = UIAlertAction(title: "OK", style: .default)
    alert.addAction(actionOK)
    return alert
}()*/
