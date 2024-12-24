//
//  LikeModel.swift
//  Aura Cinema
//
//  Created by MacBook Air on 17.01.25.
//

class LikeModel {
    private let movieService = MovieService()
    
    func getLikedFilmsData(ids: [Int]) async throws -> [Movie] {
        guard !ids.isEmpty else { return [] }
        let result = try await movieService.fetchMovies(for: .likedMovies(ids))
        return result
    }
}
