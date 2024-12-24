//
//  LikePresenter.swift
//  Aura Cinema
//
//  Created by MacBook Air on 17.01.25.
//

import Foundation

protocol LikedFilmsDelegate {
    func configureView(with movies: [MovieViewData])
    func showErrorDataAlert(title: String, message: String, alertType: AlertType)
}

class LikePresenter {
    private let model = LikeModel()
    private let savedFilmsService = SavedFilmsService()
    var delegate: LikedFilmsDelegate?
    var viewDelegate: FavoritesUpdateDelegate?
}

@MainActor
extension LikePresenter {
    func fetchLikedMovies() {
        Task {
            let ids = await self.getSavedFilms()
            do {
                let movieData = try await self.model.getLikedFilmsData(ids: ids)
                let movieModel = MovieViewModel(movieData: movieData, savedFilms: ids)
                let movies = movieModel.movies()
                delegate?.configureView(with: movies)
            } catch {
                delegate?.showErrorDataAlert(title: "Ошибка загрузки",
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
                viewDelegate?.didUpdateLikedMovies(title: "",
                                                   message: "Фильм добавлен в избарнное!",
                                                   alertType: .timed(time: 0.3))
            case .failure(let error):
                let result = self.savedFilmsService.handleError(error: error)
                viewDelegate?.showErrorFavoritesUpdate(title: result.title,
                                                       message: result.message,
                                                       alertType: .timed(time: 0.5))
            }
        }
    }
}


private extension LikePresenter {
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
