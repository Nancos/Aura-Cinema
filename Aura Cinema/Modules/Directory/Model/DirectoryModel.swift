import UIKit

final class DirectoryModel {
    private let movieService = MovieService.shared
    
    func getMoviesData(with queryItems: [URLQueryItem]) async throws -> [Movie] {
        let result: MovieResponse = try await movieService.fetch(.filters(queryItems))
        return result.docs
    }
}
