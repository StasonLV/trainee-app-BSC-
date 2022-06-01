//
//  NoteDetailViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 01.06.2022.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    private let interactor: NoteDetailsBusinessLogic
    public let router: NoteDetailsRoutingLogic

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(
      interactor: NoteDetailsBusinessLogic,
      router: NoteDetailsRoutingLogic
    ) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
