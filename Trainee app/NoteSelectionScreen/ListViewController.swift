//
//  NoteSelectionViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 08.04.2022.
//

import UIKit

class ListViewController: UIViewController, MyDataSendingDelegateProtocol {

    let listView = ListView().self
    var notes = [NoteModel]()
    var containerViews = [NoteContainerView]()
    var completionHandler: ((NoteModel) -> Void)?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listView.scrollViewForStack.layoutIfNeeded()
        listView.scrollViewForStack.translatesAutoresizingMaskIntoConstraints = false
        listView.stackViewForContainers.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }

    override func viewWillLayoutSubviews() {
        listView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        listView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }

    func sendDatatoFirstViewController(note: NoteModel) -> NoteContainerView {
        let container = NoteContainerView()
        container.noteNameLabel.text = note.title
        container.noteTextLabel.text = note.noteText
        container.noteDateLabel.text = note.date
        notes.append(note)
        containerViews.append(container)
        updateStackView()
        return container
    }

    func setupVC() {
        view.backgroundColor = .systemBackground
        view.addSubview(listView)
        self.title = "Заметки"
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(pushExistingNote)
        )
        listView.stackViewForContainers.addGestureRecognizer(tapGesture)
    }

    func updateStackView() {
        listView.stackViewForContainers.arrangedSubviews.forEach {
                    $0.removeFromSuperview()
                }
        containerViews.forEach { item in
            listView.stackViewForContainers.addArrangedSubview(item)
            listView.stackViewForContainers.sizeToFit()
                }
        listView.stackViewForContainers.distribution = .fill
    }

//        let stackHeight = containerViews.count * 90
//        listView.stackViewForContainers.heightAnchor.constraint(equalToConstant: CGFloat(stackHeight))
//        listView.stackViewForContainers.distribution = .fill
//    }
//        for item in containerViews {
//            item.isUserInteractionEnabled = true
//            listView.stackViewForContainers.addArrangedSubview(item)
//        }

    @objc func createNewNote() {
        let newNoteVC = NoteViewController()
        newNoteVC.delegate = self
        newNoteVC.title = "Note Pad"
        self.navigationController?.pushViewController(newNoteVC, animated: true)
    }

    //    @objc func tap(_ gesture: UITapGestureRecognizer) {
    //        let location = gesture.location(in: listView.stackViewForContainers)
    //            print("location = \(location)")
    //            var locationInView = CGPoint.zero
    //        let subViews = listView.stackViewForContainers.subviews
    //            for subView in subViews {
    //                locationInView = subView.convert(location, from: listView.stackViewForContainers)
    //                if subView.isKind(of: NoteContainerView.self) {
    //                    if subView.point(inside: locationInView, with: nil) {
    //                        print("Subview at \(subView.tag) tapped")
    //                        break
    //                    }
    //                }

    @objc func pushExistingNote(_ sender: NoteContainerView) {
        completionHandler?(NoteModel(
            title: sender.noteNameLabel.text,
            noteText: sender.noteTextLabel.text,
            date: sender.noteDateLabel.text)
        )
//        print("\(sender.noteNameLabel.text ?? "some")")
//        print("\(sender.noteTextLabel.text ?? "some")")
//        print("\(sender.noteNameLabel.text ?? "some")")
                let newNoteVC = NoteViewController()
                newNoteVC.delegate = self
                newNoteVC.title = "Note Pad"
                self.navigationController?.pushViewController(newNoteVC, animated: true)
    }
}
