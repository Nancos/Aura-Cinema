//
//  DirectoryModel.swift
//  Aura Cinema
//
//  Created by MacBook Air on 23.01.25.
//

import UIKit

class DirectoryModel {
    private let movieService = MovieService()
    
    func getMoviesData(with queryItems: [URLQueryItem]) async throws -> [Movie] {
        return try await movieService.fetchMovies(for: .filters(queryItems))
    }
}
