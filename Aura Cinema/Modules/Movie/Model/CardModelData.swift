import Foundation

enum MovieCellItem {
    case movieButtons(ModelMovieButtonsCell)
    case movieDescription(ModelMovieDescriptionCell)
    case movieInfo(ModelMovieInfoCell)
    case moviePoster(ModelMoviePosterCell)
    case movieTitle(ModelMovieTitleCell)
    case moviePerson([ModelMoviePersonCell])
}

struct ModelMoviePosterCell {
    let posterURL: String
}

struct ModelMovieTitleCell {
    let title: String
    let originalTitle: String
}

struct ModelMovieInfoCell {
    let ratingKP: String
    let releaseYear: String
    let genres: String
    let countries: String
    let length: String
    let ageRating: String
}

struct ModelMovieButtonsCell {
    let id: Int
    let saved: Bool
    let trailers: [ModelMovieTrailers]
}

struct ModelMovieTrailers {
    let url: String
    let name: String
    let site: String
    let type: String
}

enum ModelMovieDescription {
    case title(String)
    case shortDescription(String)
    case description(String)
    case ageRating(String)
}

struct ModelMovieDescriptionCell {
    let shortDescription: String
    let description: String
    let ageRating: String
    let title: String
    
    init(shortDescription: String = "", description: String = "", ageRating: String = "", title: String = "") {
        self.shortDescription = shortDescription
        self.description = description
        self.ageRating = ageRating
        self.title = title
    }
}

struct ModelMoviePersonCell {
    let personID: Int
    let personPhoto: String
    let personName: String
}

struct MovieCard {
    private let cardData: MovieCardData
    private let trailers: [TrailerInfo]
    private let savedFilms: [Int]
    
    init(cardData: MovieCardData, trailers: [TrailerInfo], savedFilms: [Int]) {
        self.cardData = cardData
        self.trailers = trailers
        self.savedFilms = savedFilms
    }
    
    var items: [MovieCellItem] {
        [.moviePoster(ModelMoviePosterCell(posterURL: cardData.poster?.url ?? String(localized: "n_a"))),
         .movieTitle(ModelMovieTitleCell(title: cardData.name ?? String(localized: "title_unknown"), originalTitle: cardData.alternativeName ?? "")),
         .movieInfo(ModelMovieInfoCell(
            ratingKP: formatRating(cardData.rating?.kp),
            releaseYear: "\(cardData.year ?? 0)г.",
            genres: formatList(cardData.genres?.compactMap {  $0.name }, prefix: String(localized: "genre")),
            countries: formatList(cardData.countries?.compactMap { $0.name }, prefix: String(localized: "country")),
            length: "\(cardData.movieLength ?? 0) \(String(localized: "minutes"))",
            ageRating: "\(cardData.ageRating ?? 0)+")),
         .movieButtons(ModelMovieButtonsCell(id: cardData.id,
                                             saved: savedFilms.contains(cardData.id),
                                             trailers: formattedTrailers)),
         .movieDescription(ModelMovieDescriptionCell(
            shortDescription: cardData.shortDescription ?? String(localized: "short_description_not_found"),
            description: cardData.description ?? String(localized: "description_not_found"),
            ageRating: "\(cardData.ageRating ?? 0)+",
            title: cardData.name ?? String(localized: "title_unknown"))),
         .moviePerson(formattedPersons)]
    }
}

private extension MovieCard {
    var formattedTrailers: [ModelMovieTrailers] {
        trailers.flatMap { $0.videos.trailers.map {
            ModelMovieTrailers(url: $0.url,
                               name: $0.name,
                               site: $0.site,
                               type: $0.type)
        }}
    }
    
    var formattedPersons: [ModelMoviePersonCell] {
        cardData.persons?.map {
            ModelMoviePersonCell(personID: $0.id ?? 0,
                                 personPhoto: $0.photo ?? "",
                                 personName: currentName(name: $0.name, enName: $0.enName))
        } ?? []
    }
    
    func currentName(name: String?, enName: String?) -> String {
        let currentLanguage = Locale.current.language.languageCode?.identifier
        let title: String
        if currentLanguage == "ru" {
            title = name ?? enName ?? String(localized: "unknown")
        } else {
            title = enName ?? name ?? String(localized: "unknown")
        }
        return title
    }
    
    func formatRating(_ rating: Double?) -> String {
        guard let rating, rating > 0 else { return "" }
        return String(format: "%.1f", rating)
    }
    
    func formatList(_ items: [String]?, prefix: String = "") -> String {
        guard let items, !items.isEmpty else { return "\(prefix): n/a" }
        let localizedItems = items.map { String(localized: String.LocalizationValue($0)).lowercased() }
        return "\(prefix): \(localizedItems.joined(separator: ", "))"
    }
}
