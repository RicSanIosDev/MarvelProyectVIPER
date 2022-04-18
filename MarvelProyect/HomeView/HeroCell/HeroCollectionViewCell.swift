//
//  HeroCollectionViewCell.swift
//  MarvelProyect
//
//  Created by Ricardo Sanchez on 11/4/22.
//


import UIKit

class HeroCollectionViewCell: UICollectionViewCell {

    static let identifier = "HeroCollectionViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageHero: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setup(name: String, url: String) {
        self.nameLabel.text = name
        self.imageHero.setImage(urlString: url, imageView: imageHero)
    }
}
