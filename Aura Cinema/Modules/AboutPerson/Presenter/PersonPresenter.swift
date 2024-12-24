import UIKit

protocol PersonDelegate: FavoritesUpdateDelegate {
    func configureView(with persons: [PersonCellItem], with movies: [MovieViewData])
    func showError(title: String, message: String, alertType: AlertType)
}

final class PersonPresenter {
    private let savedFilmsService = SavedFilmsService.shared
    private let model = PersonModel()
    var delegate: PersonDelegate?
}

@MainActor
extension PersonPresenter {
    func fetchPersonData(with id: Int) {
        Task {
            let ids = await getSavedFilms()
            do {
                let personData = try await model.getPesonData(id: id)
                let movieData = try await model.getFilmographyData(ids: personData.1)
                delegate?.configureView(with: personData.0, with: MovieViewData.movies(movieData: movieData, savedFilms: ids))
            } catch {
                delegate?.showError(title: String(localized: "Error"),
                                    message: String(localized: "error_fetching_movie_card") + "\(error)",
                                    alertType: .standardDefault)
            }
        }
    }
    
    func didLikeMovie(withID id: Int){
        savedFilmsService.addSavedFilms(movie: SavedFilmData(id: id)) { [weak self] result in
    
            guard let `self` else { return }
            
            switch result {
            case .success:
                delegate?.didUpdateLikedMovies(title: "", message: String(localized: "movie_added_to_favorites"), alertType: .timed(time: 0.3))
            case .failure(let error):
                let result = self.savedFilmsService.handleError(error: error)
                delegate?.showErrorFavoritesUpdate(title: result.title,
                                                       message: result.message,
                                                       alertType: .timed(time: 0.5))
                
            }
        }
    }
}

private extension PersonPresenter {
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
