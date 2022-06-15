//
//  NoteListAssembly.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import UIKit

enum NoteListAssembly {
    static func build() -> UIViewController {
        let presenter = NoteListPresenter()
        let worker = NoteListWorker()
        let interactor = NoteListInteractor(presenter: presenter, worker: worker)
        let router = NoteListRouter(dataStore: interactor)
        let viewController = NoteListViewController(interactor: interactor, router: router)

        presenter.view = viewController
        router.viewController = viewController

        return viewController
    }
}
