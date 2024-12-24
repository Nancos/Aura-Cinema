//
//  SearchModel.swift
//  Aura Cinema
//
//  Created by MacBook Air on 10.01.25.
//

import Foundation

class SearchModel {
    private let movieService = MovieService()
    
    func getSearchedData(with text: String) async throws -> [Movie] {
        return try await movieService.fetchMovies(for: .searchMovie(text))
    }
}
