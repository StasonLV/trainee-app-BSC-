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

    func presentDeletedNotes(_ response: NoteListCleanModel.DeleteData.Response) {
        let viewModel = response.notesAfterDeletion.map {
            NoteListCleanModel.FetchData.ViewModel(
                title: $0.title,
                noteText: $0.noteText,
                date: $0.date,
                userShareIcon: $0.userShareIcon,
                selectionState: false
            )
        }
        view?.presentDeletedNotes(viewModel)
    }

    func presentFetchedNotes(_ response: [NoteListCleanModel.FetchData.Response]) {
        let viewModel = response.map {
            NoteListCleanModel.FetchData.ViewModel(
                title: $0.header,
                noteText: $0.text,
                date: $0.date,
                userShareIcon: UIImage(),
                selectionState: false
            )
        }
        view?.displayInitForm(viewModel)
    }

//    func downloadImageFrom(urlString: String, completion: @escaping ((UIImage) -> Void)) {
//       DispatchQueue.global().async { [weak self] in
//           guard let url = URL(string: urlString) else { return }
//           guard let data = try? Data(contentsOf: url),
//                 let image = UIImage(data: data)
//           else { return }
//           DispatchQueue.main.async {
//               completion(image)
//           }
//       }
//   }
//    func downloadImage(with url: String, completion: @escaping (UIImage?) -> Void) {
//        DispatchQueue.global().async { [weak self] in
//            guard let url = URL(string: url) else { return }
//            guard let data = try? Data(contentsOf: url),
//                  let image = UIImage(data: data)
//            else { return }
//        resultHandler:{ image in
//            DispatchQueue.main.async {
//                completion(image)
//            }
//            }
//        }
//    }
//    func downloadImage(url: String, handler: @escaping((_ image: UIImage) -> Void)) {
//            guard let url = URL(string: url) else { return }
//        DispatchQueue.global().async {
//            guard let data = try? Data(contentsOf: url),
//                  let image = UIImage(data: data)
//            else { return }
//                handler(image)
//            }
//        }
}

extension UIImage {
//    func downloadImage1(urlString: String) -> UIImage {
//        var image1: UIImage
//       DispatchQueue.global().async { [weak self] in
//           guard let url = URL(string: urlString) else { return }
//           guard let data = try? Data(contentsOf: url),
//                 let image = UIImage(data: data)
//           else { return }
//           image1 = image
//
//           DispatchQueue.main.async {
//               return image1
//           }
//       }
//   }
// }

// extension UIImageView {
//    func loadFrom(URLAddress: String) {
//        guard let url = URL(string: URLAddress) else {
//            return
//        }
//        DispatchQueue.main.async { [weak self] in
//            if let imageData = try? Data(contentsOf: url) {
//                if let loadedImage = UIImage(data: imageData) {
//                        self?.image = loadedImage
//                }
//            }
//        }
//    }
// }
}
