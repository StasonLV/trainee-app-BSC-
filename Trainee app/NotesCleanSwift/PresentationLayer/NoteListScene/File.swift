//
//  NoteListViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import UIKit

final class NoteListViewController: UIViewController, NoteListDisplayLogic {
    private let interactor: NoteListBusinessLogic
    private let router: NoteListRoutingLogic

    init(interactor: NoteListBusinessLogic, router: NoteListRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initForm()
        view.backgroundColor = .red
    }

    // MARK: - CounterDisplayLogic

    func displayInitForm(_ viewModel: NoteListCleanModel.InitForm.ViewModel) {}

    // MARK: - Private

    private func initForm() {
        interactor.requestInitForm(NoteListCleanModel.InitForm.Request())
    }
}
