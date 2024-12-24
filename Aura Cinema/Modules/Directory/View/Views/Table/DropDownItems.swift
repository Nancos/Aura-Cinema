//
//  MovieSearchItems.swift
//  Aura Cinema
//
//  Created by MacBook Air on 21.01.25.
//

enum Items {
    case filterCategory(MovieСategoryItems.Type)
    case filterGenre(MovieGenreItems.Type)
    case filterCountry(MovieCountryItems.Type)
}

enum MovieСategoryItems: String, CaseIterable {
    case anime = "anime"
    case cartoon = "cartoon"
    case movie = "movie"
    case tvSeries = "tv-series"
    case animatedSeried = "animated-series"
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
    case melodrama = "келодрама"
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
}
