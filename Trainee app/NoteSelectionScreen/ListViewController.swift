//
//  ListViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 17.04.2022.
//

import UIKit

final class ListViewController: UIViewController {

    // MARK: - константы
    private let notesTable = UITableView(frame: .zero, style: .insetGrouped)
    private let savedNotesKey = "My Key"
    var notes = [NoteModel]()
    static let buttonSymbol = UIImage(systemName: "plus", withConfiguration: buttonSymbolConfig)
    static let buttonSymbolConfig = UIImage.SymbolConfiguration(pointSize: 36, weight: .thin, scale: .default)

    private let plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        button.layer.cornerRadius = 25
        button.setImage(buttonSymbol, for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.addTarget(
            NoteViewController(),
            action: #selector(createNewNote),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotesTable()
        addSaveNotificationOnAppDismiss()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeSaveNotificationOnAppDismiss()
    }

    // MARK: - сетап таблицы
    private func setupNotesTable () {
        title = "Заметки"
        self.notesTable.separatorStyle = .none
        notesTable.dataSource = self
        notesTable.delegate = self
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        view.addSubview(notesTable)
        view.addSubview(plusButton)
        view.bringSubviewToFront(plusButton)
        notesTable.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        notesTable.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            notesTable.topAnchor.constraint(equalTo: view.topAnchor),
            notesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalTo: plusButton.widthAnchor)
        ])
        notesTable.register(NotePreviewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - метод для кнопки "плюс" + кложур для новых заметок
    @objc private func createNewNote() {
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

    // MARK: - методы для сохранения и загрузки массива заметок
    @objc private func saveArrayOfNotes() {
        let notesData = try? JSONEncoder().encode(notes)
        UserDefaults.standard.set(notesData, forKey: savedNotesKey)
    }

    func loadArrrayOfNotes() {
        guard let notesData = UserDefaults.standard.data(forKey: savedNotesKey) else {
            print("массив пуст")
            return
        }
        do {
            notes = try JSONDecoder().decode([NoteModel].self, from: notesData)
        } catch {
            print("ошибка во время загрузки массива")
        }
    }

    private func addSaveNotificationOnAppDismiss() {
        let saveNotification = NotificationCenter.default
        saveNotification.addObserver(self,
                                     selector: #selector(saveArrayOfNotes),
                                     name: UIScene.willDeactivateNotification,
                                     object: nil)
    }

    private func removeSaveNotificationOnAppDismiss() {
        let saveNotification = NotificationCenter.default
        saveNotification.removeObserver(self)
    }
}

// MARK: - экстеншн для функционала тэйблвью
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NotePreviewCell
        let currentNotes = notes[indexPath.row]
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: notesTable.bounds.width)
        cell?.layoutMargins = UIEdgeInsets.zero
        cell?.contentView.layer.masksToBounds = true
        cell?.note = currentNotes
        return cell ?? NotePreviewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = notes[indexPath.row]
        let noteVC = NoteViewController()
        noteVC.noteView.titleField.text = model.title
        noteVC.noteView.noteText.text = model.noteText
        noteVC.noteView.dateField.text = model.date
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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
    }
}
