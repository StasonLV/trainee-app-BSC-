//
//  NotePreviewCell.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 17.04.2022.
//

import UIKit

// protocol NotePreviewCellDelegate: AnyObject {
//    func checkboxToggle(sender: NotePreviewCell)
//}
//
// final class NotePreviewCell: UITableViewCell {
//    // MARK: - константы
//    private enum Constants {
//        enum FontConstants {
//            static let noteNameFont: UIFont = .systemFont(ofSize: 16, weight: .bold)
//            static let noteTextFont: UIFont = .systemFont(ofSize: 10, weight: .light)
//            static let noteDateFont: UIFont = .systemFont(ofSize: 10, weight: .regular)
//        }
//        enum CheckmarkConstants {
//            static let buttonSymbolConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .heavy, scale: .default)
//            static let cellEditSymbol = UIImage(
//                systemName: "checkmark.circle",
//                withConfiguration: buttonSymbolConfig
//            )
//            static let cellChooseSymbol = UIImage(
//                systemName: "checkmark.circle.fill",
//                withConfiguration: buttonSymbolConfig
//            )
//        }
//        enum ViewConstants {
//            static let viewBackColor = CGColor(
//                red: 0.898,
//                green: 0.898,
//                blue: 0.898,
//                alpha: 1
//            )
//        }
//    }
//    // Ссылка опциональна
//    weak var delegate: NotePreviewCellDelegate?
//
//    // MARK: - модель
//    var note: NoteModel? {
//        didSet {
//            noteNameField.text = note?.title
//            noteTextLabel.text = note?.noteText
//            noteDateLabel.text = note?.date
//        }
//    }
//
//    // MARK: - создание эл-тов ячеек
//    lazy var checkButton: UIButton = {
//        let btn = UIButton()
//        btn.setImage(Constants.CheckmarkConstants.cellEditSymbol, for: .normal)
//        btn.setImage(Constants.CheckmarkConstants.cellChooseSymbol, for: .selected)
//        btn.alpha = 0.0
//        btn.addTarget(self, action: #selector(cellSelected), for: .touchUpInside)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.isUserInteractionEnabled = true
//        return btn
//    }()
//
//    private let noteNameField: UITextField = {
//        let label = UITextField()
//        label.font = Constants.FontConstants.noteNameFont
//        label.placeholder = "Без названия"
//        label.textColor = .black
//        label.contentMode = .scaleAspectFit
//        label.isUserInteractionEnabled = false
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let noteTextLabel: UILabel = {
//        let label = UILabel()
//        label.font = Constants.FontConstants.noteTextFont
//        label.textColor = .placeholderText
//        label.contentMode = .scaleAspectFit
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let noteDateLabel: UITextField = {
//        let label = UITextField()
//        label.font = Constants.FontConstants.noteDateFont
//        label.textColor = .black
//        label.isUserInteractionEnabled = false
//        label.text = Date().toString(format: "dd.MM.yyyy")
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    lazy var userShareIcon: UIImageView = {
//        let img = UIImageView()
//        img.translatesAutoresizingMaskIntoConstraints = false
//        return img
//    }()
//
//    // MARK: - инициализаторы
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCell()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.note = nil
//        self.userShareIcon = .init(image: UIImage.add)
//    }
//
//    // MARK: - настройка ячейки
//    func setupCell() {
//        backgroundColor = .clear
//        contentView.backgroundColor = .white
//        contentView.layer.masksToBounds = true
//        contentView.layer.cornerRadius = 15
//        contentView.layer.borderWidth = 2
//        contentView.layer.borderColor = Constants.ViewConstants.viewBackColor
//        contentView.addSubview(noteNameField)
//        contentView.addSubview(noteTextLabel)
//        contentView.addSubview(noteDateLabel)
//        contentView.addSubview(checkButton)
//        contentView.addSubview(userShareIcon)
//
//        NSLayoutConstraint.activate([
//            checkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            noteNameField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            noteNameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            noteTextLabel.topAnchor.constraint(equalTo: noteNameField.bottomAnchor, constant: 4),
//            noteTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            noteDateLabel.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: 24),
//            noteDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            userShareIcon.heightAnchor.constraint(equalToConstant: 24),
//            userShareIcon.widthAnchor.constraint(equalToConstant: 24),
//            userShareIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
//            userShareIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
//        ])
//    }
//
//    // MARK: - метод для тапа по чекбоксу
//    @objc func cellSelected(sender: UIButton) {
//        delegate?.checkboxToggle(sender: self)
//    }
//
//    // MARK: - настройка данных ячейки
//    func setupCellData(with model: NoteModel) {
//        self.note = model
//        noteNameField.text = model.title
//        noteTextLabel.text = model.noteText
//        noteDateLabel.text = model.date
//    }
//
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        if isEditing {
//            contentAnimationForStartEditing()
//        } else {
//            contentAnimationForEndEditing()
//        }
//    }
//}
//
//// MARK: - анимации
//extension NotePreviewCell {
//    private func contentAnimationForStartEditing() {
//        UIView.animate(
//            withDuration: 1.0,
//            delay: 0.0,
//            animations: {
//                self.noteNameField.transform = CGAffineTransform(translationX: 25, y: 0)
//                self.noteTextLabel.transform = CGAffineTransform(translationX: 25, y: 0)
//                self.noteDateLabel.transform = CGAffineTransform(translationX: 25, y: 0)
//                self.checkButton.alpha = 1.0
//            }
//        )
//    }
//
//    private func contentAnimationForEndEditing() {
//        UIView.animate(
//            withDuration: 1.0,
//            delay: 0.0,
//            animations: {
//                self.noteNameField.transform = .identity
//                self.noteTextLabel.transform = .identity
//                self.noteDateLabel.transform = .identity
//                self.checkButton.alpha = 0.0
//            }
//        )
//    }
//}
