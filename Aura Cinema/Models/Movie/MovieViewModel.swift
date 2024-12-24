import UIKit

enum RatingType: String {
    case kp = "kP"
    case imdb = "IMDb"
}

struct MovieViewData {
    let id: Int
    let title: String
    let posterURL: String
    let ratingKP: String?
    let ratingKPColor: UIColor
    let ratingIMDB: String?
    let ratingIMDBColor: UIColor
    let saved: Bool
}

struct MovieViewModel {
    
    private let movieData: [Movie]
    private let savedFilms: [Int]

    init(movieData: [Movie], savedFilms: [Int]) {
        self.movieData = movieData
        self.savedFilms = savedFilms
    }

    func movies() -> [MovieViewData] {
        return movieData.map { movie in
            let kpRating = movie.rating?.kp ?? 0
            let imdbRating = movie.rating?.imdb ?? 0
            return MovieViewData(
                id: movie.id,
                title: movie.name ?? movie.alternativeName ?? "Unknown Title",
                posterURL: movie.poster?.url ?? "",
                ratingKP: formatRating(kpRating, type: .kp),
                ratingKPColor: ratingColor(for: kpRating),
                ratingIMDB: formatRating(imdbRating, type: .imdb),
                ratingIMDBColor: ratingColor(for: imdbRating),
                saved: savedFilms.contains(movie.id)
            )
        }
    }
}

// MARK: - Private Methods -
private extension MovieViewModel {
    func formatRating(_ rating: Double, type: RatingType) -> String {
        let formattedRating: String
        switch type {
        case .kp:
            formattedRating = String(format: "   kP: %.1f   ", rating)
        case .imdb:
            formattedRating = String(format: "   IMDb: %.1f   ", rating)
        }
        return formattedRating
    }
    
    func ratingColor(for rating: Double) -> UIColor {
        switch rating {
        case 7.5...10:
            return .green
        case 6.5..<7.5:
            return .yellow
        case 5..<6.5:
            return .gray
        case 0:
            return .gray
        default:
            return .red
        }
    }
}
