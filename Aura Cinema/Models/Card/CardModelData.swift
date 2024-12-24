//
//  MovieEnums.swift
//  Aura Cinema
//
//  Created by MacBook Air on 10.01.25.
//

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

struct CardViewModel {
    private let cardData: MovieCardData
    private let trailers: [TrailerInfo]
    private let savedFilms: [Int]
    
    init(cardData: MovieCardData, trailers: [TrailerInfo], savedFilms: [Int]) {
        self.cardData = cardData
        self.trailers = trailers
        self.savedFilms = savedFilms
    }
    
    var items: [MovieCellItem] {
        [.moviePoster(ModelMoviePosterCell(posterURL: cardData.poster?.url ?? "n/a")),
         .movieTitle(ModelMovieTitleCell(title: cardData.name ?? "Название: n/a", originalTitle: cardData.alternativeName ?? "")),
         .movieInfo(ModelMovieInfoCell(
            ratingKP: formatRating(cardData.rating?.kp),
            releaseYear: "\(cardData.year ?? 0)г.",
            genres: formatList(cardData.genres?.compactMap { $0.name }, prefix: "Жанр"),
            countries: formatList(cardData.countries?.compactMap { $0.name }, prefix: "Страна"),
            length: "\(cardData.movieLength ?? 0) мин",
            ageRating: "\(cardData.ageRating ?? 0)+")),
         .movieButtons(ModelMovieButtonsCell(id: cardData.id,
                                             saved: savedFilms.contains(cardData.id),
                                             trailers: formattedTrailers)),
         .movieDescription(ModelMovieDescriptionCell(
            shortDescription: cardData.shortDescription ?? "Краткое описание не найдено...",
            description: cardData.description ?? "Описание не найдено...",
            ageRating: "\(cardData.ageRating ?? 0)+",
            title: cardData.name ?? "Название: n/a")),
         .moviePerson(formattedPersons)]
    }
}

private extension CardViewModel {
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
                                 personName: $0.name ?? $0.enName ?? "")
        } ?? []
    }
    
    func formatRating(_ rating: Double?) -> String {
        guard let rating, rating > 0 else { return "" }
        return String(format: "%.1f", rating)
    }
    
    func formatList(_ items: [String]?, prefix: String = "") -> String {
        guard let items, !items.isEmpty else { return "\(prefix): n/a" }
        return "\(prefix): \(items.joined(separator: ", "))"
    }
}
