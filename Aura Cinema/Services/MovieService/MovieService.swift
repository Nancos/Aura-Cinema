import Foundation

final class MovieService {
    
    static let shared = MovieService()
    
    private let networkHelper = NetworkHelper.shared
      
    func fetch<T: Decodable>(_ fetchType: FetchesMovie) async throws -> T {
        let request = try networkHelper.createRequest(for: fetchType)
        return try await networkHelper.fetchData(from: request)
    }
}

enum NetworkError: Error {
    case invalidURL
    case httpError(statusCode: Int)
    case decodingError(error: Error)
    case invalidResponce
    case noData
    case unknown(error: Error)
    case sessionError(error: Error)
}
