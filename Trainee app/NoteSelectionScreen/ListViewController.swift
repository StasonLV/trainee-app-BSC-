//
//  ListViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 17.04.2022.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate {
    let notesTable = UITableView(frame: .zero, style: .insetGrouped)
    var safeArea: UILayoutGuide!
    var notes = [NoteModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        createNoteArray()
        setupNotesTable()
        notesTable.dataSource = self
        notesTable.delegate = self
    }

    func setupNotesTable () {
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        safeArea = view.layoutMarginsGuide
        view.addSubview(notesTable)
        view.addSubview(plusButton)
        view.bringSubviewToFront(plusButton)
        plusButton.frame = CGRect(x: 321, y: 734, width: 50, height: 50)
        notesTable.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        notesTable.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            notesTable.topAnchor.constraint(equalTo: safeArea.topAnchor),
            notesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            notesTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        notesTable.register(NotePreviewCell.self, forCellReuseIdentifier: "cell")
    }

    @objc func createNewNote() {
        let newNoteVC = NoteViewController()
        newNoteVC.delegate = self
        newNoteVC.title = "Note Pad"
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }

    func createNoteArray() {
        notes.append(NoteModel(title: "Privet", noteText: "dliinyy text ghbasdasdasfaf ", date: "17.01.2022"))
        notes.append(NoteModel(title: "Poka", noteText: "dliinyy text ghbasdasdasfaf ", date: "17.01.2022"))
        notes.append(NoteModel(title: "Privet", noteText: "dliinyy text ghbasdasdasfaf ", date: "17.01.2022"))
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NotePreviewCell
        let currentLastNote = notes[indexPath.row]
        cell!.note = currentLastNote
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let spacing: CGFloat = 10
//        let maskLayer = CALayer()
//        maskLayer.cornerRadius = 15
//        maskLayer.backgroundColor = UIColor.white.cgColor
//        maskLayer.frame = CGRect(origin: cell.bounds.origin, size: <#T##CGSize#>)
//    }
}

 extension ListViewController: MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(note: NoteModel) {
        notes.append(note)
        print(notes.count)
        print("added")
    }
 }
