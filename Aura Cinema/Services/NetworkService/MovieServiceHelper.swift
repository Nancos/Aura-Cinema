//
//  MovieServiceHelper.swift
//  Aura Cinema
//
//  Created by MacBook Air on 24.01.25.
//

import Foundation

enum FetchesMovie {
    case top250movies
    case top20of2023
    case vampireMovies
    case searchMovie(String)
    case likedMovies([Int])
    case filmography([Int])
    case filters([URLQueryItem])
    case trailer(Int)
    
    var path: String {
        switch self {
        case .top250movies, .top20of2023, .vampireMovies, .filmography, .filters, .trailer, .likedMovies:
            return "/v1.4/movie"
        case .searchMovie:
            return "/v1.4/movie/search"
        }
    }
    
    var description: String {
        switch self {
        case .top250movies:
            return "250 лучших фильмов: "
        case .top20of2023:
            return "Топ-20 фильмов и сериалов 2023 года: "
        case .vampireMovies:
            return "Фильмы про вампиров: "
        case .searchMovie(let text):
            return "Поиск по фильмам: \(text): "
        default:
            return ""
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .top250movies:
            return [URLQueryItem(name: "lists", value: "top250")]
        case .top20of2023:
            return [URLQueryItem(name: "lists", value: "top20of2023")]
        case .vampireMovies:
            return [URLQueryItem(name: "lists", value: "theme_vampire")]
        case .searchMovie(let text):
            return [URLQueryItem(name: "query", value: text)]
        case .filmography(let ids):
            var query = [URLQueryItem(name: "sortField", value: "rating.kp"),
                         URLQueryItem(name: "sortType", value: "-1")]
            query.append(contentsOf: ids.map { URLQueryItem(name: "id", value: "\($0)") })
            return query
        case .likedMovies(let ids):
            return ids.map { URLQueryItem(name: "id", value: "\($0)") }
        case .filters(let filtres):
            let baseQuery = [URLQueryItem(name: "sortField", value: "lists"),
                             URLQueryItem(name: "sortType", value: "-1")]
            return baseQuery + filtres
        case .trailer(let id):
            let baseQuery = [URLQueryItem(name: "selectFields", value: "id"),
                             URLQueryItem(name: "selectFields", value: "videos"),
                             URLQueryItem(name: "id", value: "\(id)")]
            return baseQuery
        }
    }
}
