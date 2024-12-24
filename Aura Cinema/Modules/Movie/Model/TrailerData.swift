// MARK: - TrailerData
struct TrailerData: Codable {
    let docs: [TrailerInfo]
    let total, limit, page, pages: Int
}

// MARK: - Doc
struct TrailerInfo: Codable {
    let id: Int
    let videos: Videos
}

// MARK: - Videos
struct Videos: Codable {
    let trailers: [Trailer]
}

// MARK: - Trailer
struct Trailer: Codable {
    let url: String
    let name, site, type: String
}
