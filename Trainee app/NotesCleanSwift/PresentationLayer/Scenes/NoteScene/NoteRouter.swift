//
//  NoteRouter.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 04.06.2022.
//

import UIKit

final class NoteRouter: NoteRoutingLogic, NoteDataPassing {
    weak var viewController: UIViewController?
    let dataStore: NoteDataStore

    init(dataStore: NoteDataStore) {
        self.dataStore = dataStore
    }
}
