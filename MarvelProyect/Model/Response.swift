//
//  Response.swift
//  MarvelProyect
//
//  Created by Ricardo Sanchez on 11/4/22.
//

import Foundation
import UIKit

enum APIError: Error {
    case unknown
    case wrongFormat
    case empyData
    case imageWrongFormat
}

struct Heros: Codable {

    let data: DataClass

}

// MARK: - DataClass
struct DataClass: Codable {

    let results: [Character]

    //    enum CodingKeys: String, CodingKey {
    //    case offset, limit, total, count
    //    case results = "results"
    //    }

}

// MARK: - Result
struct Character: Codable {
    let id: Int
    let name, resultDescription: String
    let thumbnail: Thumbnail


    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail
    }

}


// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path, thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }

}

class HeroImage {
    internal init(image: UIImage = UIImage()) {
        self.image = image
    }

    var image = UIImage()
}
