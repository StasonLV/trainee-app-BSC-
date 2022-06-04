//
//  NoteListRouter.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import UIKit

final class NoteListRouter: NoteListRoutingLogic, NoteListDataPassing {
    weak var viewController: UIViewController?
    let dataStore: NoteListDataStore

    init(dataStore: NoteListDataStore) {
        self.dataStore = dataStore
    }

    func createNewNote() {
        let noteVC = NoteAssembly.build()
        viewController?.navigationController?.pushViewController(noteVC, animated: true)
    }

    func didSelectRow() {
    }
}

private extension NoteListRouter {
//    func passDataTo_() {
//        source: CounterDataStore,
//        destination: inout SomewhereDataStore
//    ) {
//    }
}
