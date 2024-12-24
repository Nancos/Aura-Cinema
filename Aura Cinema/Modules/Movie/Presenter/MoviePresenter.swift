protocol MovieDelegate: FavoritesUpdateDelegate {
    func configureMovie(with card: [MovieCellItem])
    func configureMovieWithError(title: String, message: String, alertType: AlertType)
}

final class MoviePresenter {
    private let savedFilmsService = SavedFilmsService.shared
    private let model = CardModel()
    var delegate: MovieDelegate?
}

@MainActor
extension MoviePresenter {
    func fetchMovieCard(kpId: Int) {
        Task {
            do {
                let cardData = try await model.getCardData(kpId: kpId)
                let trailerData = await fetchMovieTrailer(kpId: kpId)
                let savedFilms = await getSavedFilms()
                
                let cardModel = MovieCard(cardData: cardData, trailers: trailerData, savedFilms: savedFilms)
                let card = cardModel.items
                delegate?.configureMovie(with: card)
            } catch {
                delegate?.configureMovieWithError(title: String(localized: "Error"),
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
                self.delegate?.didUpdateLikedMovies(title: "",
                                                        message: String(localized: "movie_added_to_favorites"),
                                                        alertType: .timed(time: 0.3))
            case .failure(let error):
                let result = self.savedFilmsService.handleError(error: error)
                self.delegate?.showErrorFavoritesUpdate(title: result.title,
                                                            message: result.message,
                                                            alertType: .timed(time: 0.5))
            }
        }
    }
}

private extension MoviePresenter {
    
    func fetchMovieTrailer(kpId: Int) async -> [TrailerInfo] {
        do {
            let trailerData = try await model.getTrailerData(kpId: kpId)
            return trailerData
        } catch {
            return []
        }
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
