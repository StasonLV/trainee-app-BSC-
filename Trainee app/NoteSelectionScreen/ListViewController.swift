//
//  ListViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 17.04.2022.
//

import UIKit

final class ListViewController: UIViewController {
    // MARK: - константы
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
    private let notesTable = UITableView(frame: .zero, style: .insetGrouped)
    var notes = [NoteModel]()
    let worker: WorkerType = Worker()
    let loading = LoadingViewController()

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

    let plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.PlusButtonConstants.plusButtonBlueColor
        button.layer.cornerRadius = 25
        button.setImage(Constants.PlusButtonConstants.buttonSymbol, for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.addTarget(
            NoteViewController(),
            action: #selector(buttonMethod),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        plusButton.center.y += 90.0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        buttonAppearAnimation()
        addIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.removeIndicator()
            self.loadArrrayOfNotes()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotesTable()
        addSaveNotificationOnAppDismiss()
        navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.title = "Выбрать"
    }

    // MARK: - сетап таблицы
    private func setupNotesTable () {
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
        notesTable.register(NotePreviewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - методы для работы лоадинг индикатора
    private func addIndicator() {
        loading.modalPresentationStyle = .overCurrentContext
        loading.modalTransitionStyle = .crossDissolve
        self.present(loading, animated: true)
    }

    private func removeIndicator() {
        loading.dismiss(animated: true)
    }

    deinit {
        print("ListVC deinited")
    }

    // MARK: - метод для кнопки "плюс" + кложур для новых заметок
    @objc private func buttonMethod() {
        if notesTable.isEditing {
            removeSelected()
        } else {
            noteCreationAnimation()
        }
    }

    private func createNewNote() {
        let newNoteVC = NoteViewController()
        DispatchQueue.main.async {
            newNoteVC.completion = { [weak self] model in
                self?.notes.append(model)
                self?.notesTable.reloadData()
            }
        }
        newNoteVC.title = "Note Pad"
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }

    // MARK: - оверрайд метода эдита
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        notesTable.setEditing(editing, animated: true)
        if isEditing {
            self.editButtonItem.title = "Готово"
            buttonForDeletionTransition()
        } else {
            self.editButtonItem.title = "Выбрать"
            buttonForAddTransition()
        }
    }

    // MARK: - метод для удаления отмеченных заметок
    private func removeSelected() {
        let filteredNotes = notes.filter { $0.selectionState }
        if filteredNotes.isEmpty {
            self.present(alert, animated: true, completion: nil)
        } else {
            for (index, note) in notes.enumerated() where note.selectionState {
                    notes.remove(at: index)
                    let indexPath = IndexPath(item: index, section: 0)
                    notesTable.beginUpdates()
                    notesTable.deleteRows(at: [indexPath], with: .automatic)
                    notesTable.reloadData()
                    notesTable.endUpdates()
                }
            }
        }

    // MARK: - методы для сохранения и загрузки массива заметок
    @objc private func saveArrayOfNotes() {
        let notesData = try? JSONEncoder().encode(notes)
        UserDefaults.standard.set(notesData, forKey: Constants.PlusButtonConstants.savedNotesKey)
    }

    func loadArrrayOfNotes() {
        // получаем заметки из сети и добавляем в конец массива дата сорс
        worker.fetch { [weak self] result in
            switch result {
            case .success(let result):
                self?.notes.append(contentsOf: result)
                DispatchQueue.main.async {
                    self?.notesTable.reloadData()
                }
            case .failure(let error):
                print("Ошибка при работе с загружаемыми данными: \(error.localizedDescription)")
            }
        }
        // получаем заметки из юзерДифолтс и добавляем в дата сорс
        guard let notesData = UserDefaults.standard.data(forKey: Constants.PlusButtonConstants.savedNotesKey),
              let cache = try? JSONDecoder().decode([NoteModel].self, from: notesData)
        else { return }
        notes.append(contentsOf: cache)
    }

    private func addSaveNotificationOnAppDismiss() {
        let saveNotification = NotificationCenter.default
        saveNotification.addObserver(
            self,
            selector: #selector(saveArrayOfNotes),
            name: UIScene.willDeactivateNotification,
            object: nil
        )
    }
}

// MARK: - экстеншн для функционала тэйблвью
extension ListViewController: UITableViewDataSource, UITableViewDelegate, NotePreviewCellDelegate {
    func checkboxToggle(sender: NotePreviewCell) {
        if let selectedIndexPath = notesTable.indexPath(for: sender) {
            notes[selectedIndexPath.row].selectionState = !notes[selectedIndexPath.row].selectionState
            notesTable.reloadRows(at: [selectedIndexPath], with: .none)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = notesTable.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? NotePreviewCell else {
            return UITableViewCell()
        }
        cell.userShareIcon.downloadImageFrom(urlString: notes[indexPath.row].userShareIcon ?? "")
        cell.delegate = self
        cell.checkButton.isSelected = notes[indexPath.row].selectionState
        cell.setupCellData(with: notes[indexPath.row])
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: notesTable.bounds.width)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.contentView.layer.masksToBounds = true
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = notes[indexPath.row]
        let noteVC = NoteViewController()
        noteVC.noteViewWithCellData(with: model)
        notes.remove(at: indexPath.row)
        noteVC.completion = { [weak self] model in
            DispatchQueue.main.async {
                self?.notes.insert(model, at: indexPath.row)
                self?.notesTable.reloadData()
            }
        }
        self.navigationController?.pushViewController(noteVC, animated: true)
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

// MARK: - экстеншн для обработки УРЛ изображения
private extension UIImageView {
    func downloadImageFrom(urlString: String) {
        DispatchQueue.global().async { [weak self] in
        guard let url = URL(string: urlString) else { return }
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            self?.image = image
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                        self?.image = image
//                }
//            }
        }
    }
}

// MARK: - анимации
// в анимациях можно пользоваться "сильным" захватом, т.к. селф в замыкании не приводит к утечке
extension ListViewController {
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
                self.createNewNote()
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
