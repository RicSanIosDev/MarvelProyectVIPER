//
//  Extension+UIImage.swift
//  MarvelProyect
//
//  Created by Ricardo Sanchez on 11/4/22.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImage(urlString: String?, imageView: UIImageView) {

        guard let urlString = urlString, let url = URL(string: urlString) else {
            print("No se pudo hacer la llamada de la IMAGE")
            return
        }

        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 15)

        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}

