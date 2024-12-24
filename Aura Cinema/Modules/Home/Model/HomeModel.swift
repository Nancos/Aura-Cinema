//
//  HomeModel.swift
//  Aura Cinema
//
//  Created by MacBook Air on 6.01.25.
//

class HomeModel {
    private let movieService = MovieService()
    
    func getMovieData(with fetch: FetchesMovie) async throws -> [Movie] {
        return try await movieService.fetchMovies(for: fetch)
    }
}
