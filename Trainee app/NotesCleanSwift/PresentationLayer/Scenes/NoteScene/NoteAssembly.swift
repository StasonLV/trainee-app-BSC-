//
//  NoteAssembly.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 04.06.2022.
//

import UIKit

enum NoteAssembly {
    static func build(
        viewModel: NoteListCleanModel.FetchData.ViewModel? = nil
    ) -> UIViewController {
        if viewModel == nil {
        let presenter = NotePresenter()
        let worker = NoteWorker()
        let interactor = NoteInteractor(presenter: presenter, worker: worker)
        let router = NoteRouter(dataStore: interactor)
        let viewController = NoteViewController(interactor: interactor, router: router)

        presenter.view = viewController
        router.viewController = viewController

        return viewController
        } else {
            let presenter = NotePresenter()
            let worker = NoteWorker()
            let interactor = NoteInteractor(presenter: presenter, worker: worker)
            let router = NoteRouter(dataStore: interactor)
            let viewController = NoteViewController(interactor: interactor, router: router)

            presenter.view = viewController
            router.viewController = viewController
            viewController.noteView.titleField.text = viewModel?.title
            viewController.noteView.noteText.text = viewModel?.noteText
            viewController.noteView.dateField.text = viewModel?.date

            return viewController
        }
    }
}
