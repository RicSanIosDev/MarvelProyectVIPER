//
//  Hero.swift
//  MarvelProyect
//
//  Created by Ricardo Sanchez on 11/4/22.
//

import Foundation

struct Hero: Codable {

    var id: Int
    var name: String
    var imageUrl: String
    var description: String
    var favorite = false

}
