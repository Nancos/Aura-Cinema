import Foundation

final class SearchModel {
    private let movieService = MovieService.shared
    
    func getSearchedData(with text: String) async throws -> [Movie] {
        let movieResponce: MovieResponse = try await movieService.fetch(.searchMovie(text))
        return movieResponce.docs
    }
}
