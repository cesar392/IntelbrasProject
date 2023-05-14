//
//  FavoritesService.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 14/05/23.
//

import Foundation

protocol FavoritesServiceProtocol {
    func addFavorite(id: String)
    func removeFavorite(id: String)
}

class FavoritesService: FavoritesServiceProtocol {
    let favoritesRepository: FavoritesRepositoryProtocol

    init(favoriteRepo: FavoritesRepositoryProtocol) {
        self.favoritesRepository = favoriteRepo
    }

    func addFavorite(id: String) {
        favoritesRepository.addFavorite(id: id)
    }

    func removeFavorite(id: String) {
        favoritesRepository.removeFavorite(id: id)
    }
}
