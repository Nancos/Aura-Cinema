//
//  DirectoryPresenter.swift
//  Aura Cinema
//
//  Created by MacBook Air on 23.01.25.
//
import UIKit

protocol DirectoryViewDelegate {
    func configureCollection(with movies: [MovieViewData])
    func showError(title: String, message: String, alertType: AlertType)
}

class DirectoryPresenter {
    private let savedFilmsService = SavedFilmsService()
    private let model = DirectoryModel()
    var delegate: DirectoryViewDelegate?
    var viewDelegate: FavoritesUpdateDelegate?
    private var queryItems: [URLQueryItem] = []
}

@MainActor
extension DirectoryPresenter {
    func fetchMovieData(category: MovieСategoryItems?, genre: [MovieGenreItems]?, country: [MovieCountryItems]?) {
        let queryItems = createQueryItems(category: category, genre: genre, country: country)
        
        Task {
            let ids = await getSavedFilms()
            do {
                let movieData = try await model.getMoviesData(with: queryItems)
                let movieModel = MovieViewModel(movieData: movieData, savedFilms: ids)
                let movies = movieModel.movies()
                self.delegate?.configureCollection(with: movies)  
            } catch {
                delegate?.showError(title: "Ошибка",
                                    message: "Error fetching movie card: \(error)",
                                    alertType: .standardDefault)
            }
        }
    }
    
    func didLikeMovie(withID id: Int){
        savedFilmsService.addSavedFilms(movie: SavedFilmData(id: id)) { [weak self] result in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success:
                self.viewDelegate?.didUpdateLikedMovies(title: "",
                                                        message: "Фильм добавлен в избарнное!",
                                                        alertType: .timed(time: 0.3))
            case .failure(let error):
                let result = self.savedFilmsService.handleError(error: error)
                self.viewDelegate?.showErrorFavoritesUpdate(title: result.title,
                                                            message: result.message,
                                                            alertType: .timed(time: 0.5))
            }
        }
    }
}

private extension DirectoryPresenter {
    func createQueryItems(category: MovieСategoryItems?, genre: [MovieGenreItems]?, country: [MovieCountryItems]?) -> [URLQueryItem] {
        queryItems = []
        
        if let category {
            let categoryQueryItem = URLQueryItem(name: "type", value: category.rawValue)
            queryItems.append(categoryQueryItem)
        }
        
        if let genre {
            for genreItem in genre {
                let genreQueryItem = URLQueryItem(name: "genres.name", value: genreItem.rawValue)
                queryItems.append(genreQueryItem)
            }
        }
        
        if let country {
            for countryItem in country {
                let countryQueryItem = URLQueryItem(name: "countries.name", value: countryItem.rawValue)
                queryItems.append(countryQueryItem)
            }
        }
        return queryItems
    }
    
    func getSavedFilms() async -> [Int] {
        return await withCheckedContinuation { continuation in
            savedFilmsService.loadSavedFilms() { result in
                switch result {
                case .success(let films):
                    let ids = films.map(\.id)
                    continuation.resume(returning: ids)
                case .failure(_):
                    continuation.resume(returning: [])
                }
            }
        }
    }
}
