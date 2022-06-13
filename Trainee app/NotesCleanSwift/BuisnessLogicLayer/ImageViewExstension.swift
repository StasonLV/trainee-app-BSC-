//
//  ImageViewExstension.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 06.06.2022.
//

import UIKit

extension UIImageView {
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

extension UIImage {
    func fetchImage(urlString: String, completion: @escaping (_ image: UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else { return }
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
