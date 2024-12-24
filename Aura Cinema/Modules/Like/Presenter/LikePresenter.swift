import Foundation

protocol LikedFilmsDelegate: FavoritesUpdateDelegate {
    func configureView(with movies: [MovieViewData])
    func showErrorDataAlert(title: String, message: String, alertType: AlertType)
}

final class LikePresenter {
    private let model = LikeModel()
    private let savedFilmsService = SavedFilmsService.shared
    var delegate: LikedFilmsDelegate?
}

@MainActor
extension LikePresenter {
    func fetchLikedMovies() {
        Task {
            let ids = await self.getSavedFilms()
            do {
                let movieData = try await self.model.getLikedFilmsData(ids: ids)
                delegate?.configureView(with: MovieViewData.movies(movieData: movieData, savedFilms: ids))
            } catch {
                delegate?.showErrorDataAlert(title: String(localized: "loading_error"),
                                             message: String(localized: "error_fetching_movie_card") + "\(error)",
                                             alertType: .standardDefault)
            }
        }
    }
    
    func didLikeMovie(withID id: Int){
        savedFilmsService.addSavedFilms(movie: SavedFilmData(id: id)) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success:
                delegate?.didUpdateLikedMovies(title: "",
                                               message: String(localized: "movie_added_to_favorites"),
                                               alertType: .timed(time: 0.3))
            case .failure(let error):
                let result = self.savedFilmsService.handleError(error: error)
                delegate?.showErrorFavoritesUpdate(title: result.title,
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
