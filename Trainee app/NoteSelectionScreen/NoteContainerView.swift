//
//  NoteContainerView.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 11.04.2022.
//

import UIKit

final class NoteContainerView: UIView {

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
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let noteTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .placeholderText
        label.contentMode = .scaleAspectFit
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupContainerView() {
        addSubview(contentContainer)
        contentContainer.addSubview(noteNameLabel)
        contentContainer.addSubview(noteTextLabel)
        contentContainer.addSubview(noteDateLabel)

        NSLayoutConstraint.activate([

            contentContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contentContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 26),
            contentContainer.heightAnchor.constraint(equalToConstant: 90),
            contentContainer.widthAnchor.constraint(greaterThanOrEqualToConstant: 358),

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
}
