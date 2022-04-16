//
//  NoteSelectionView.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 07.04.2022.
//

import UIKit

final class ListView: UIView {

    static let buttonSymbol = UIImage(systemName: "plus", withConfiguration: buttonSymbolConfig)
    static let buttonSymbolConfig = UIImage.SymbolConfiguration(pointSize: 36, weight: .thin, scale: .default)

    var stackViewForContainers: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 4
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let scrollViewForStack: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
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
            action: #selector(ListViewController.createNewNote),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNoteListView()
        addPlusButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupNoteListView() {
        addSubview(scrollViewForStack)
        scrollViewForStack.addSubview(stackViewForContainers)

        NSLayoutConstraint.activate([
            scrollViewForStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollViewForStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollViewForStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollViewForStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            stackViewForContainers.topAnchor.constraint(equalTo: scrollViewForStack.topAnchor),
            stackViewForContainers.leadingAnchor.constraint(equalTo: scrollViewForStack.leadingAnchor),
            stackViewForContainers.trailingAnchor.constraint(equalTo: scrollViewForStack.trailingAnchor),
            stackViewForContainers.widthAnchor.constraint(equalTo: scrollViewForStack.widthAnchor)
        ])
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
}
