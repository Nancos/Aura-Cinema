import Foundation

// MARK: - Response
struct MovieResponse: Codable {
    let total: Int
    let limit: Int
    let page: Int
    let pages: Int
    let docs: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let name: String?
    let alternativeName: String?
    let enName: String?
    let type: String?
    let year: Int?
    let description: String?
    let shortDescription: String?
    let slogan: String?
    let rating: Rating?
    let poster: Poster?
    let backdrop: Backdrop?
    let genres: [Genre]?
    let countries: [Country]?
    let persons: [Person]?
    let movieLength: Int?
    let ageRating: Int?
    let isSeries: Bool?
    let seriesLength: Int?
    let seasonsInfo: [SeasonInfo]?
    let similarMovies: [Int]?
    let status: String?
    
    // MARK: - Rating
    struct Rating: Codable {
        let kp: Double?
        let imdb: Double?
    }
    // MARK: - Poster
    struct Poster: Codable {
        let url: String?
        let previewURL: String?
    }
    // MARK: - Backdrop
    struct Backdrop: Codable {
        let url: String?
        let previewURL: String?
    }
    // MARK: - Genre
    struct Genre: Codable {
        let name: String?
    }
    // MARK: - Country
    struct Country: Codable {
        let name: String?
    }
    
    struct Person: Codable {
        let id: Int?
        let photo: String?
        let name: String?
        let enName: String?
    }
    
    // MARK: - SeasonInfo
    struct SeasonInfo: Codable {
        let number: Int?
        let episodesCount: Int?
    }
}
