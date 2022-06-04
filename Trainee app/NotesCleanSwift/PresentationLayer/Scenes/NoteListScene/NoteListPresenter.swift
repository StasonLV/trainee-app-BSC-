//
//  NoteListPresenter.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 02.06.2022.
//
import Foundation
import UIKit

final class NoteListPresenter: NoteListPresentationLogic {
    weak var view: NoteListDisplayLogic?

    func presentFetchedNotes(_ response: [NoteListCleanModel.FetchData.Response]) {
        let fetchedNotes = response.map { NoteListCleanModel.FetchData.ViewModel(
            title: $0.header,
            noteText: $0.text,
            date: $0.date?.toString(format: "dd.MM.yyyy"),
            userShareIcon: $0.userShareIcon,
            selectionState: false
        )
        }
        view?.displayInitForm(fetchedNotes)
    }
}

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru")
        return dateFormatter.string(from: self)
    }
}

private extension UIImageView {
    func downloadImageFrom(urlString: String) {
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: urlString) else { return }
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
