//
//  NoteSceneConfigurator.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 01.06.2022.
//

import Foundation
import UIKit

enum SearchSceneAssembly {
  static func builder() -> UIViewController {
    let presenter = NoteDetailsPresenter()
    let router = NoteDetailsRouter()
    let interactor = NoteDetailsInteractor(presenter: presenter)
    let viewController = NoteDetailViewController(
        interactor: interactor,
        router: router
    )

    router.viewController = viewController
    presenter.viewController = viewController
    router.dataStore = interactor

    return viewController
  }
}
