//
//  HomePresenter.swift
//  Aura Cinema
//
//  Created by MacBook Air on 6.01.25.
//

import Foundation

// MARK: - HomeDelegate -
protocol HomeDelegate {
    func configureView(with movies: [(String, [MovieViewData])])
    func showError(title: String, message: String, alertType: AlertType)
}

class HomePresenter {
    private let savedFilmsService = SavedFilmsService()
    private let model = HomeModel()
    var delegate: HomeDelegate?
    var viewDelegate: FavoritesUpdateDelegate?
}

@MainActor
extension HomePresenter {
    func fetchMovieData(with fetches: [FetchesMovie]) {
        Task {
            let ids = await getSavedFilms()
            do {
                var arrayMoviesData: [(String, [MovieViewData])] = []
                for fetch in fetches {
                    let movieData = try await model.getMovieData(with: fetch)
                    let movieModel = MovieViewModel(movieData: movieData, savedFilms: ids)
                    let movies = movieModel.movies()
                    arrayMoviesData.append((fetch.description, movies))
                }
                delegate?.configureView(with: arrayMoviesData)
            } catch {
                delegate?.showError(title: "Ошибка загрузки",
                                    message: "Ошибка при обработке данных фильмов: \(error)",
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

private extension HomePresenter {
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
