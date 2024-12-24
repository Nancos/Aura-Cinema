enum FilterType {
    case filterCategory
    case filterGenre
    case filterCountry
    
    var allItems: ([String],[String]) {
        switch self {
            case .filterCategory:
                return (MovieСategoryItems.allCases.map { String($0.rawValue) },
                        MovieСategoryItems.allCases.map { String($0.localized) })
            case .filterGenre:
                return (MovieGenreItems.allCases.map { String($0.rawValue) },
                        MovieGenreItems.allCases.map { String($0.localized) })
            case .filterCountry:
                return (MovieCountryItems.allCases.map { String($0.rawValue) },
                        MovieCountryItems.allCases.map { String($0.localized)})
        }
    }
}

enum MovieСategoryItems: String, CaseIterable {
    case anime = "anime"
    case cartoon = "cartoon"
    case movie = "movie"
    case tvSeries = "tv-series"
    case animatedSeries = "animated-series"
    
    var localized: String { String(localized: String.LocalizationValue(rawValue)) }
}

enum MovieGenreItems: String, CaseIterable {
    case anime = "аниме"
    case biografiya = "биография"
    case boevik = "боевик"
    case vestern = "вестерн"
    case voennyy = "военный"
    case detektiv = "детектив"
    case detskiy = "детский"
    case dokumentalnyy = "документальный"
    case drama = "драма"
    case igra = "игра"
    case istoriya = "история"
    case komediya = "комедия"
    case koncert = "концерт"
    case korotkometrazhka = "короткометражка"
    case kriminal = "криминал"
    case melodrama = "мелодрама"
    case muzyka = "музыка"
    case multfilm = "мультфильм"
    case myuzikl = "мюзикл"
    case novosti = "новости"
    case priklyucheniya = "приключения"
    case semeynyy = "семейный"
    case sport = "спорт"
    case triller = "триллер"
    case uzhasy = "ужасы"
    case fantastika = "фантастика"
    case fentezi = "фэнтези"
    case ceremoniya = "церемония"
    
    var localized: String { String(localized: String.LocalizationValue(rawValue)) }
}

enum MovieCountryItems: String, CaseIterable {
    case Australia = "Австралия"
    case Austria = "Австрия"
    case Azerbaijan = "Азербайджан"
    case Belgium = "Бельгия"
    case Brazil = "Бразилия"
    case Canada = "Канада"
    case China = "Китай"
    case Denmark = "Дания"
    case Finland = "Финляндия"
    case France = "Франция"
    case Germany = "Германия"
    case India = "Индия"
    case Indonesia = "Индонезия"
    case Israel = "Израиль"
    case Italy = "Италия"
    case Japan = "Япония"
    case Kazakhstan = "Казахстан"
    case Netherlands = "Нидерланды"
    case Norway = "Норвегия"
    case Poland = "Польша"
    case Russia = "Россия"
    case SouthKorea = "Корея Южная"
    case Spain = "Испания"
    case Sweden = "Швеция"
    case Switzerland = "Швейцария"
    case Turkey = "Турция"
    case UAE = "ОАЭ"
    case UK = "Великобритания"
    case Ukraine = "Украина"
    case USA = "США"
    
    var localized: String { String(localized: String.LocalizationValue(rawValue)) }
}
