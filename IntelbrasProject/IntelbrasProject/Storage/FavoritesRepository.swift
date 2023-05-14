//
//  FavoritesRepository.swift
//  IntelbrasProject
//
//  Created by Cesar Comelli on 14/05/23.
//

import Foundation
import RxSwift

protocol FavoritesRepositoryProtocol {
    var favorites: Observable<Set<String>> { get }
    func addFavorite(id: String)
    func removeFavorite(id: String)
}

class InMemoryFavoriteRepository: FavoritesRepositoryProtocol {

//    TODO: Get favorite from database
    private var _favorites = BehaviorSubject<Set<String>>(value: Set<String>())

    var favorites: Observable<Set<String>> {
        return _favorites.asObservable()
    }

    func addFavorite(id: String) {
        var currentFavorites = try! _favorites.value()
        currentFavorites.insert(id)
        _favorites.onNext(currentFavorites)
    }

    func removeFavorite(id: String) {
        var currentFavorites = try! _favorites.value()
        currentFavorites.remove(id)
        _favorites.onNext(currentFavorites)
    }

}
