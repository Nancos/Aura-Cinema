struct MovieCardData: Codable {
    let id: Int
    let name: String?
    let alternativeName: String?
    let year: Int?
    let description: String?
    let shortDescription: String?
    let movieLength: Int?
    let ageRating: Int?
    let rating: Rating?
    let poster: Backdrop?
    let countries: [Genre]?
    let genres: [Country]?
    let persons: [Person]?
    
}
struct Rating: Codable {
    let kp: Double?
}
    
struct Backdrop: Codable {
    let url: String?
    let previewURL: String?
}
    
struct Country: Codable {
    let name: String?
}
    
struct Genre: Codable {
    let name: String?
}
    
struct Person: Codable {
    let id: Int?
    let photo: String?
    let name: String?
    let enName: String?
}
