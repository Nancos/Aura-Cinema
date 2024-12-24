//
//  MovieService.swift
//  Aura Cinema
//
//  Created by MacBook Air on 4.01.25.
//

import Foundation

class MovieService {
    
    private let networkHelper = NetworkHelper()
    
    private func fetchData<T: Decodable>(path: String, queryItems:[URLQueryItem] = []) async throws -> T {
        do {
            let request = try networkHelper.createRequest(path: path, queryItems: queryItems)
            let response: T = try await networkHelper.fetchData(from: request)
            return response
        } catch let error as NetworkError {
            switch error {
            case .invalidURL:
                throw MovieServiceError.invalidURL
            case .httpError(let statusCode):
                throw MovieServiceError.apiError(message: "HTTP error \(statusCode)")
            case .decodingError:
                throw MovieServiceError.decodingFailed
            case .invalidResponce:
                throw MovieServiceError.invalidResponse
            case .noData:
                throw MovieServiceError.noData
            case .unknown(let error):
                throw MovieServiceError.apiError(message: error.localizedDescription)
            case .sessionError(error: let error):
                throw MovieServiceError.apiError(message: error.localizedDescription)
            }
        } catch {
            throw MovieServiceError.apiError(message: error.localizedDescription)
        }
    }
    
    func fetchMovies(for selected: FetchesMovie, page: Int = 1, limit: Int = 50) async throws -> [Movie] {
        var queryItems = [URLQueryItem(name: "page", value: String(page)),
                                  URLQueryItem(name: "limit", value: String(limit))]
        queryItems.append(contentsOf: selected.queryItems)
        let responce: MovieResponse = try await fetchData(path: selected.path, queryItems: queryItems)
        return responce.docs
    }
    
    func fetchPerson(with id: Int) async throws -> PersonModelData {
        let responce: PersonModelData = try await fetchData(path: "/v1.4/person/\(id)")
        return responce
    }

    func fetchMovieCard(id: Int) async throws -> MovieCardData {
        let responce: MovieCardData = try await fetchData(path: "/v1.4/movie/\(id)")
        return responce
    }
    
    func fetchTrailers(for selected: FetchesMovie, page: Int = 1, limit: Int = 1) async throws -> [TrailerInfo] {
        var queryItems = [URLQueryItem(name: "page", value: String(page)),
                          URLQueryItem(name: "limit", value: String(limit))]
        queryItems.append(contentsOf: selected.queryItems)
        let responce: TrailerData = try await fetchData(path: selected.path, queryItems: queryItems)

        return responce.docs
    }
}
