//
//  MoviePresenter.swift
//  Aura Cinema
//
//  Created by MacBook Air on 5.01.25.
//

protocol MovieDelegate {
    func configureMovie(with card: [MovieCellItem])
    func configureMovieWithError(title: String, message: String, alertType: AlertType)
}

class MoviePresenter {
    private let savedFilmsService = SavedFilmsService()
    private let model = CardModel()
    var delegate: MovieDelegate?
    var viewDelegate: FavoritesUpdateDelegate?
}

@MainActor
extension MoviePresenter {
    func fetchMovieCard(kpId: Int) {
        Task {
            do {
                let cardData = try await model.getCardData(kpId: kpId)
                let trailerData = await fetchMovieTrailer(kpId: kpId)
                let savedFilms = await getSavedFilms()
                
                let cardModel = CardViewModel(cardData: cardData, trailers: trailerData, savedFilms: savedFilms)
                let card = cardModel.items
                delegate?.configureMovie(with: card)
            } catch {
                delegate?.configureMovieWithError(title: "Ошибка",
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
