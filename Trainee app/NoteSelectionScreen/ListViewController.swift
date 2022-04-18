//
//  NoteSelectionViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 08.04.2022.
//

import UIKit

class ListViewController: UIViewController {

    let listView = ListView().self
    var notes = [NoteModel]()
    var currentNote: NoteModel?

    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupVC()
        updateStackView()
        listView.scrollViewForStack.layoutIfNeeded()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        listView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        listView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    // MARK: установка интерфейса
    private func setupVC() {
        view.backgroundColor = .systemBackground
        view.addSubview(listView)
        listView.stackViewForContainers.distribution = .fill
        self.title = "Заметки"
    }

    // MARK: метод для кнопки "плюс"
    @objc func createNewNote() {
        let newNoteVC = NoteViewController()
        newNoteVC.delegate = self
        newNoteVC.title = "Note Pad"
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }

    // MARK: метод обновления стека
    private func updateStackView() {
        listView.stackViewForContainers.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        notes.forEach { item in
            let container = NoteContainerView()
            container.callback = { [weak self] model in
                let noteVC = NoteViewController()
                noteVC.configureNoteView(with: model)
                self?.navigationController?.pushViewController(noteVC, animated: true)
            }
            container.translatesAutoresizingMaskIntoConstraints = false
            container.model = item
            listView.stackViewForContainers.addArrangedSubview(container)
        }
    }
}

// MARK: экстеншн с делегатом
extension ListViewController: MyDataSendingDelegateProtocol {
    func sendDatatoFirstViewController(note: NoteModel) {
        notes.append(note)
    }
}
