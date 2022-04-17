//
//  NotePreviewCell.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 17.04.2022.
//

import UIKit

final class NotePreviewCell: UITableViewCell {

    var completion: ((NoteModel) -> Void)?

    struct Constants {

    }

    var note: NoteModel? {
        didSet {
            noteNameLabel.text = note?.title
            noteTextLabel.text = note?.noteText
            noteDateLabel.text = note?.date
        }
    }

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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = CGColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
