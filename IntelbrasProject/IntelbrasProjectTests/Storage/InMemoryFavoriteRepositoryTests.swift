//
//  InMemoryFavoriteRepositoryTests.swift
//  IntelbrasProjectTests
//
//  Created by Cesar Comelli on 15/05/23.
//

import XCTest
@testable import IntelbrasProject
@testable import RxBlocking

final class InMemoryFavoriteRepositoryTests: XCTestCase {

    private var favoriteRepository: InMemoryFavoriteRepository!

    override func setUpWithError() throws {
        favoriteRepository = InMemoryFavoriteRepository()
    }

    func test_givenFavoriteWasAdded_whenGettingFavorites_thenShouldReturnFavorite() throws {
        let favoriteToAdd = "123"
        favoriteRepository.addFavorite(id: favoriteToAdd)
        let favorites = try! favoriteRepository.favorites.toBlocking().first()
        let containsFavoriteAdded = favorites?.contains(favoriteToAdd)
        XCTAssertNotNil(containsFavoriteAdded)
        XCTAssertTrue(containsFavoriteAdded!)
    }

    func test_givenFavoriteWasRemoved_whenGettingFavorites_thenShouldNotReturnFavorite() throws {
        let favoriteToAdd = "123"
        favoriteRepository.addFavorite(id: favoriteToAdd)
        favoriteRepository.removeFavorite(id: favoriteToAdd)
        let favorites = try! favoriteRepository.favorites.toBlocking().first()
        let containsFavoriteAdded = favorites?.contains(favoriteToAdd)
        XCTAssertNotNil(containsFavoriteAdded)
        XCTAssertFalse(containsFavoriteAdded!)
    }
}
