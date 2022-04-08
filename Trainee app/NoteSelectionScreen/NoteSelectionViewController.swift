//
//  NoteSelectionViewController.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 08.04.2022.
//

import UIKit

class NoteSelectionViewController: UIViewController {
    
    let addNoteButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 321, y: 704, width: 50, height: 50))
        button.backgroundColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(addNoteButton)
        view.backgroundColor = .cyan
    }
    
    @objc func createNewNote() {
        
    }
    

}
