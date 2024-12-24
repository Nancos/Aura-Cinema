final class HomeModel {
    private let movieService = MovieService.shared
    
    func getMovieData(with fetch: FetchesMovie) async throws -> [Movie] {
        let result: MovieResponse = try await movieService.fetch(fetch)
        return result.docs
    }
}
