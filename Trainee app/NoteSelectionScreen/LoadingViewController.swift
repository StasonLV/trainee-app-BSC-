//
//  IndicatorExtension.swift
//  Trainee app
//
//  Created by Stanislav Lezovsky on 24.05.2022.
//

import Foundation
import UIKit
final class LoadingViewController: UIViewController {
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indic = UIActivityIndicatorView()
        indic.style = .medium
        indic.color = .white
        indic.startAnimating()
        indic.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        return indic
    }()

    var blurEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.6
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        view.addSubview(loadingActivityIndicator)
    }

    deinit {
        print("LoadingVC deinited")
    }
}
