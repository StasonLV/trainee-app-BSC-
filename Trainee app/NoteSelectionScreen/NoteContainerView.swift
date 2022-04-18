//
//  NoteContainerView.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 11.04.2022.
//

import UIKit

final class NoteContainerView: UIView {

    struct Constants {
        let titleFont: UIFont = .systemFont(ofSize: 16, weight: .bold)
        let noteFont: UIFont = .systemFont(ofSize: 10, weight: .light)
        let dateFont: UIFont = .systemFont(ofSize: 10, weight: .regular)
    }

    var callback: ((NoteModel) -> Void)?

    var model: NoteModel? {
        didSet {
            guard let model = model else { return }
            noteNameLabel.text = model.title
            noteTextLabel.text = model.noteText
            noteDateLabel.text = model.date
        }
    }

    // MARK: создание элементов
    let contentContainer: UIView = {
        let content = UIView()
        content.backgroundColor = .white
        content.sizeToFit()
        content.layoutIfNeeded()
        content.layer.cornerRadius = 15
        content.clipsToBounds = true
        content.layer.masksToBounds = true
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()

    let noteNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants().titleFont
        label.textColor = .black
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let noteTextLabel: UILabel = {
        let label = UILabel()
        label.font = Constants().noteFont
        label.textColor = .placeholderText
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let noteDateLabel: UITextField = {
        let label = UITextField()
        label.font = Constants().dateFont
        label.textColor = .black
        label.isUserInteractionEnabled = false
        label.text = Date().toString(format: "dd.MM.yyyy")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: инициализаторы
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
        addTapToContainer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: констрейнты контейнера
    private func setupContainerView() {
        self.heightAnchor.constraint(equalToConstant: 90).isActive = true
        addSubview(contentContainer)
        contentContainer.addSubview(noteNameLabel)
        contentContainer.addSubview(noteTextLabel)
        contentContainer.addSubview(noteDateLabel)

        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
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

    // MARK: создание жеста "тап"
    private func addTapToContainer() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(pushExistingNote)
        )
        contentContainer.addGestureRecognizer(tapGesture)
    }

    // MARK: метод для жеста "тап"
    @objc private func pushExistingNote() {
        print("tap")
        guard let model = model else { return }
        callback?(model)
    }
}
