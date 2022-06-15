//
//  ConnectionAlert.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 15.06.2022.
//
import UIKit

enum InteractorAlerts {
    static let connectionAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "Проблемы с сетью",
            message: "Не удалось загрузить данные из сети",
            preferredStyle: .alert
        )
        let actionOK = UIAlertAction(title: "Окей", style: .default)
        alert.addAction(actionOK)
        return alert
    }()

    static let decodingAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "Список пуст",
            message: "Проблемы с обработкой заметок",
            preferredStyle: .alert
        )
        let actionOK = UIAlertAction(title: "Окей", style: .default)
        alert.addAction(actionOK)
        return alert
    }()
}
