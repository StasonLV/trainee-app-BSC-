//
//  ListViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 17.04.2022.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate {
    static let buttonSymbol = UIImage(systemName: "plus", withConfiguration: buttonSymbolConfig)
    static let buttonSymbolConfig = UIImage.SymbolConfiguration(pointSize: 36, weight: .thin, scale: .default)
    let notesTable = UITableView(frame: .zero, style: .insetGrouped)
    var notes = [NoteModel]()
    let plusButton: UIButton = {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        notesTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotesTable()
    }

    func setupNotesTable () {
        notesTable.dataSource = self
        notesTable.delegate = self
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        view.addSubview(notesTable)
        view.addSubview(plusButton)
        view.bringSubviewToFront(plusButton)
        plusButton.frame = CGRect(x: 321, y: 734, width: 50, height: 50)
        notesTable.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        notesTable.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            notesTable.topAnchor.constraint(equalTo: view.topAnchor),
            notesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 761),
            plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 250),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalTo: plusButton.widthAnchor)
        ])
        notesTable.register(NotePreviewCell.self, forCellReuseIdentifier: "cell")
    }

    @objc func createNewNote() {
        let newNoteVC = NoteViewController()
        newNoteVC.delegate = self
        newNoteVC.title = "Note Pad"
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NotePreviewCell
        let currentNotes = notes[indexPath.row]
        cell?.note = currentNotes
        return cell ?? NotePreviewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = notes[indexPath.row]
        let noteVC = NoteViewController()
        self.navigationController?.pushViewController(noteVC, animated: true)
        print(model)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

 extension ListViewController: MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(note: NoteModel) {
        notes.append(note)
        print(notes.count)
        print("added")
    }
 }
