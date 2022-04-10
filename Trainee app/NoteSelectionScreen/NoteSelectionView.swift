//
//  NoteSelectionView.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 07.04.2022.
//

import UIKit

final class NoteSelectionView: UIView {

    static let buttonSymbol = UIImage(systemName: "plus", withConfiguration: buttonSymbolConfig)
    static let buttonSymbolConfig = UIImage.SymbolConfiguration(pointSize: 36, weight: .thin, scale: .default)
    
    let stackViewForContainers: UIStackView = {
        let stack = UIStackView()
        for value in arrayOfNotes {
            stack.addArrangedSubview(contentContainer)
        }
        return stack
    }()

    let scrollViewForContainers: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = false
        scroll.backgroundColor = .cyan
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    let contentContainer: UIView = {
        let content = UIView()
        content.backgroundColor = .white
        content.layer.cornerRadius = 15
        content.layer.masksToBounds = true
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()

    let noteNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.text = "Какое то название заметки"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let noteTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .placeholderText
        label.text = "Какой то текст заметки очень дилнный, который не помещается в контейнер"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let noteDateLabel: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .black
        label.text = Date().toString(format: "dd MMMM yyyy")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let addNoteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        button.layer.cornerRadius = 25
        button.setImage(buttonSymbol, for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.addTarget(
            NoteViewController(),
            action: #selector(NoteSelectionViewController.createNewNote),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNoteListView()
        getPreviewData()
        addPlusButton()
        addNoteContainers(toView: self, count: arrayOfNotes.count)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupNoteListView() {
        addSubview(scrollViewForContainers)
        scrollViewForContainers.addSubview(contentContainer)
        contentContainer.addSubview(noteNameLabel)
        contentContainer.addSubview(noteTextLabel)
        contentContainer.addSubview(noteDateLabel)

        NSLayoutConstraint.activate([
            scrollViewForContainers.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollViewForContainers.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollViewForContainers.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollViewForContainers.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            contentContainer.leadingAnchor.constraint(equalTo: scrollViewForContainers.leadingAnchor, constant: 16),
            contentContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contentContainer.topAnchor.constraint(equalTo: scrollViewForContainers.topAnchor, constant: 26),
            contentContainer.heightAnchor.constraint(equalToConstant: 90),

            noteNameLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 10),
            noteNameLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 16),
            noteNameLabel.heightAnchor.constraint(equalToConstant: 18),

            noteTextLabel.topAnchor.constraint(equalTo: noteNameLabel.bottomAnchor, constant: 4),
            noteTextLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 16),
            noteTextLabel.heightAnchor.constraint(equalToConstant: 14),
            noteTextLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -5),

            noteDateLabel.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: 24),
            noteDateLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 16),
            noteDateLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }

    func addNoteContainers(toView: NoteSelectionView, count: Int) {
        for notes in arrayOfNotes {
            scrollViewForContainers.addSubview(contentContainer)

        }
    }
    
    func addPlusButton() {
        addSubview(addNoteButton)
        
        NSLayoutConstraint.activate([
            addNoteButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -19),
            addNoteButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -60),
            addNoteButton.heightAnchor.constraint(equalToConstant: 50),
            addNoteButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    func getPreviewData() {
        if let decodedNote = UserDefaults.standard.object(forKey: "first") as? Data {
            if let noteData = try? JSONDecoder().decode(NoteModel.self, from: decodedNote) {
                noteNameLabel.text = noteData.title
                noteTextLabel.text = noteData.noteText
                noteDateLabel.text = noteData.date
            }
        }
    }
}
