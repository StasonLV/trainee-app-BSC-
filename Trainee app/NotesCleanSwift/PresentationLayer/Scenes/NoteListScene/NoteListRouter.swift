//
//  NoteListRouter.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 01.06.2022.
//

import UIKit

protocol NoteListRouter: AnyObject {
    var navigationController: UINavigationController? { get }
    
    func routeToNote(with id: String)
}

class NoteListRouter: NoteListRoutingLogic {
    weak var navigationController: UINavigationController?
    
    func routeToNote(with id: String) {
        let viewController = NoteDetailViewController()
        NoteDetailConfigurator.configureModule(
            titleId: id,
            viewController: viewController
        )
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
