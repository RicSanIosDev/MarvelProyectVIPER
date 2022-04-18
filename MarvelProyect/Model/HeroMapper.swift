//
//  HeroMapper.swift
//  MarvelProyect
//
//  Created by Ricardo Sanchez on 11/4/22.
//

import Foundation

class HeroMapper {
    static func mapHero(response: Heros) -> [Hero] {
        var heros: [Hero] = []
        for item in response.data.results {
            let hero = Hero(id: item.id,name: item.name, imageUrl: "\(item.thumbnail.path).\(item.thumbnail.thumbnailExtension)", description: item.resultDescription)
            heros.append(hero)
        }
        return heros
    }
}
