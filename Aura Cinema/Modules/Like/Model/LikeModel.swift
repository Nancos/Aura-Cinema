final class LikeModel {
    private let movieService = MovieService.shared
    
    func getLikedFilmsData(ids: [Int]) async throws -> [Movie] {
        guard !ids.isEmpty else { return [] }
        let result: MovieResponse = try await movieService.fetch(.likedMovies(ids))
        return result.docs
    }
}
