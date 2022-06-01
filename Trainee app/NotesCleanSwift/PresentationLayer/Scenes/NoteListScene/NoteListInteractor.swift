//
//  NoteListInteractor.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 01.06.2022.
//

import Foundation

protocol NoteListInteractorProtocol: AnyObject {
    
    func createNewNote()
    
    func removeSelectedNotes()
    
    func didSelectRow(at index: Int)
    
}

final class NoteListInteractor: NoteListInteractorProtocol {
    func didSelectRow(at index: Int) {
        
    }
    
    @objc func createNewNote() {
            let newNoteVC = NoteViewController()
            DispatchQueue.main.async {
                newNoteVC.completion = { [weak self] model in
                    self?.notes.append(model)
                    self?.notesTable.reloadData()
                }
            }
            newNoteVC.title = "Note Pad"
            self.navigationController?.pushViewController(newNoteVC, animated: true)
        }
    
    func removeSelectedNotes() {
        <#code#>
    }
    }
