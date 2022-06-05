//
//  NoteListViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//

import UIKit

final class NoteListViewController: UIViewController {
    // MARK: - константы
    private var notes = [NoteListCleanModel.FetchData.ViewModel]()
    private enum Constants {
        enum ColorConstants {
            static let viewBackColor = UIColor(
                red: 0.898,
                green: 0.898,
                blue: 0.898,
                alpha: 1
            )
        }
        enum PlusButtonConstants {
            static let buttonSymbolConfig = UIImage.SymbolConfiguration(pointSize: 36, weight: .thin, scale: .default)
            static let plusButtonBlueColor = UIColor(
                red: 0,
                green: 0.478,
                blue: 1,
                alpha: 1
            )
            static let buttonSymbol = UIImage(systemName: "plus", withConfiguration: buttonSymbolConfig)
            static let savedNotesKey = "My Key"
        }
        enum AlertConstants {
            static let alertTitle = "Нечего удалять"
            static let alertButtonText = "Продолжить"
            static let alertMessage = "Не выбрано ни одной заметки для удаления"
        }
    }
    let notesTable = UITableView(frame: .zero, style: .insetGrouped)
    private let interactor: NoteListBusinessLogic
    private let router: NoteListRoutingLogic

    lazy var alert: UIAlertController = {
        let alert = UIAlertController(
            title: Constants.AlertConstants.alertTitle,
            message: Constants.AlertConstants.alertMessage,
            preferredStyle: .alert
        )
        let actionOK = UIAlertAction(title: Constants.AlertConstants.alertButtonText, style: .cancel)
        alert.addAction(actionOK)
        return alert
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.PlusButtonConstants.plusButtonBlueColor
        button.layer.cornerRadius = 25
        button.setImage(Constants.PlusButtonConstants.buttonSymbol, for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.addTarget(
            self,
            action: #selector(selectorForPlus),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(interactor: NoteListBusinessLogic, router: NoteListRoutingLogic) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        plusButton.center.y += 90.0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        buttonAppearAnimation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotesTable()
        initForm()
    }

    @objc func selectorForPlus() {
        noteCreationAnimation()
    }

    // MARK: - сетап таблицы
    private func setupNotesTable() {
        title = "Заметки"
        self.notesTable.separatorStyle = .none
        notesTable.dataSource = self
        notesTable.delegate = self
        view.backgroundColor = Constants.ColorConstants.viewBackColor
        view.addSubview(notesTable)
        view.addSubview(plusButton)
        view.bringSubviewToFront(plusButton)
        notesTable.backgroundColor = Constants.ColorConstants.viewBackColor
        notesTable.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            notesTable.topAnchor.constraint(equalTo: view.topAnchor),
            notesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: +60),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalTo: plusButton.widthAnchor)
        ])
        notesTable.register(NoteCellView.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - DisplayLogic

    // MARK: - Private
    private func initForm() {
            self.interactor.requestInitForm(NoteListCleanModel.InitForm.Request())
            print(self.notes)
    }
}

// MARK: - экстеншн для функционала тэйблвью
extension NoteListViewController: UITableViewDataSource, UITableViewDelegate {
//    func checkboxToggle(sender: NotePreviewCell) {
//        if let selectedIndexPath = notesTable.indexPath(for: sender) {
//            notes[selectedIndexPath.row].selectionState = !notes[selectedIndexPath.row].selectionState
//            notesTable.reloadRows(at: [selectedIndexPath], with: .none)
//        }
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = notesTable.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? NoteCellView else {
            return UITableViewCell()
        }
//        cell.userShareIcon.downloadImageFrom(urlString: notes[indexPath.row].userShareIcon ?? "")
//        cell.checkButton.isSelected = notes[indexPath.row].selectionState
//        cell.setupCellData(with: notes[indexPath.row])
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: notesTable.bounds.width)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.contentView.layer.masksToBounds = true
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = notes[indexPath.row]
        router.showNote(for: indexPath.row)
//        let model = notes[indexPath.row]
//        let noteVC = NoteViewController()
//        noteVC.noteViewWithCellData(with: model)
//        notes.remove(at: indexPath.row)
//        noteVC.completion = { [weak self] model in
//            DispatchQueue.main.async {
//                self?.notes.insert(model, at: indexPath.row)
//                self?.notesTable.reloadData()
//            }
//        }
//        self.navigationController?.pushViewController(noteVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            notesTable.beginUpdates()
            notes.remove(at: indexPath.row)
            notesTable.deleteRows(at: [indexPath], with: .left)
            notesTable.endUpdates()
        }
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        return .none
    }
}

extension NoteListViewController {
    private func buttonAppearAnimation() {
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            usingSpringWithDamping: 0.1,
            initialSpringVelocity: 10.0,
            options: [],
            animations: {
                self.plusButton.center.y -= 90.0
                self.view.layoutSubviews()
            },
            completion: nil
        )
    }

    private func noteCreationAnimation() {
        UIView.animateKeyframes(
            withDuration: 1.0,
            delay: 0.0,
            options: [],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.0,
                    relativeDuration: 0.25,
                    animations: {
                        self.plusButton.center.y -= 50.0
                    }
                )
                UIView.addKeyframe(
                    withRelativeStartTime: 0.25,
                    relativeDuration: 0.75,
                    animations: {
                        self.plusButton.center.y += 150.0
                    }
                )
            },
            completion: { _ in
                self.router.createNewNote()
                self.plusButton.center.y -= 100.0
            }
        )
    }

    private func buttonForDeletionTransition() {
        UIView.animate(
            withDuration: 1.0,
            animations: {
                self.plusButton.backgroundColor = .red
                self.plusButton.transform = CGAffineTransform(rotationAngle: 40)
            },
            completion: nil
        )
    }

    private func buttonForAddTransition() {
        UIView.animate(
            withDuration: 1.0,
            animations: {
                self.plusButton.backgroundColor = Constants.PlusButtonConstants.plusButtonBlueColor
                self.plusButton.transform = .identity
            },
            completion: nil
        )
    }
}

extension NoteListViewController: NoteListDisplayLogic {
    func displayInitForm(_ viewModel: [NoteListCleanModel.FetchData.ViewModel]) {
            self.notes.append(contentsOf: viewModel)
            print(self.notes)
            self.notesTable.reloadData()
    }
}
