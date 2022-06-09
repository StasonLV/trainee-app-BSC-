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
