//
//  PersonModel.swift
//  Aura Cinema
//
//  Created by MacBook Air on 12.01.25.
//
import Foundation

class PersonModel {
    private let movieService = MovieService()
    
    func getPesonData(id: Int) async throws -> PersonModelData {
        return try await movieService.fetchPerson(with: id)
    }
    
    func getFilmographyData(ids: [Int]) async throws -> [Movie] {
        return try await movieService.fetchMovies(for: .filmography(ids))
    }
}
