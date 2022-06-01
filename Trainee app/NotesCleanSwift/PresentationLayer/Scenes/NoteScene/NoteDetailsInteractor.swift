//
//  NoteDetailsInteractor.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 01.06.2022.
//

import Foundation

final class NoteDetailsInteractor: NoteDetailsDataStore {
    public let presenter: NoteDetailsPresentationLogic
    
    init(presenter: NoteDetailsPresentationLogic) {
        self.presenter = presenter
    }
}
