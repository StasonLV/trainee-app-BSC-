//
//  NotePreviewCell.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 17.04.2022.
//

import UIKit

final class NotePreviewCell: UITableViewCell {

    // MARK: - константы
    struct Constants {
        let noteNameFont: UIFont = .systemFont(ofSize: 16, weight: .bold)
        let noteTextFont: UIFont = .systemFont(ofSize: 10, weight: .light)
        let noteDateFont: UIFont = .systemFont(ofSize: 10, weight: .regular)
        let backColor = CGColor(
            red: 0.898,
            green: 0.898,
            blue: 0.898,
            alpha: 1
        )
    }

    // MARK: - модель
    var note: NoteModel? {
        didSet {
            noteNameLabel.text = note?.title
            noteTextLabel.text = note?.noteText
            noteDateLabel.text = note?.date
        }
    }

    // MARK: - создание эл-тов ячеек
    let noteNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants().noteNameFont
        label.textColor = .black
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let noteTextLabel: UILabel = {
        let label = UILabel()
        label.font = Constants().noteTextFont
        label.textColor = .placeholderText
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let noteDateLabel: UITextField = {
        let label = UITextField()
        label.font = Constants().noteDateFont
        label.textColor = .black
        label.text = Date().toString(format: "dd.MM.yyyy")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - инициализаторы
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - настройка ячейки
    func setupCell() {
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = Constants().backColor
        contentView.addSubview(noteNameLabel)
        contentView.addSubview(noteTextLabel)
        contentView.addSubview(noteDateLabel)

        NSLayoutConstraint.activate([
            noteNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            noteNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noteTextLabel.topAnchor.constraint(equalTo: noteNameLabel.bottomAnchor, constant: 4),
            noteTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noteDateLabel.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: 24),
            noteDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
}
