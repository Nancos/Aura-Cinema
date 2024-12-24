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
    case movieCard(Int)
    case personCard(Int)
    
    var path: String {
        switch self {
        case .searchMovie:
            return "/v1.4/movie/search"
        case .movieCard(let id):
            return "/v1.4/movie/\(id)"
        case .personCard(let id):
            return "/v1.4/person/\(id)"
        default:
            return "/v1.4/movie"
        }
    }
    
    var description: String {
        switch self {
        case .top250movies: return String(localized: "top250movies")
        case .top20of2023: return String(localized: "top20of2023")
        case .vampireMovies: return String(localized: "vampireMovies")
        default: return ""
        }
    }
    
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        // Общие параметры
        items.append(URLQueryItem(name: "page", value: String(1)))
        items.append(URLQueryItem(name: "limit", value: String(50)))
        
        switch self {
        case .top250movies:
            items.append(URLQueryItem(name: "lists", value: "top250"))
        case .top20of2023:
            items.append(URLQueryItem(name: "lists", value: "top20of2023"))
        case .vampireMovies:
            items.append(URLQueryItem(name: "lists", value: "theme_vampire"))
        case .searchMovie(let text):
            items.append(URLQueryItem(name: "query", value: text))
        case .filmography(let ids), .likedMovies(let ids):
            items.append(URLQueryItem(name: "sortField", value: "rating.kp"))
            items.append(URLQueryItem(name: "sortType", value: "-1"))
            items.append(contentsOf: ids.map { URLQueryItem(name: "id", value: "\($0)") })
        case .filters(let filters):
            items.append(URLQueryItem(name: "sortField", value: "lists"))
            items.append(URLQueryItem(name: "sortType", value: "-1"))
            items.append(contentsOf: filters)
        case .trailer(let id):
            items.append(URLQueryItem(name: "selectFields", value: "id"))
            items.append(URLQueryItem(name: "selectFields", value: "videos"))
            items.append(URLQueryItem(name: "id", value: "\(id)"))
        case .personCard, .movieCard:
            return []
        }
        
        return items
    }
}
