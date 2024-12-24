//
//  PersonPresenter.swift
//  Aura Cinema
//
//  Created by MacBook Air on 12.01.25.
//

import UIKit

protocol PersonDelegate {
    func configureView(with persons: [PersonCellItem], with movies: [MovieViewData])
    func showError(title: String, message: String, alertType: AlertType)
}

class PersonPresenter {
    private let savedFilmsService = SavedFilmsService()
    private let model = PersonModel()
    var delegate: PersonDelegate?
    var viewDelegate: FavoritesUpdateDelegate?
}

@MainActor
extension PersonPresenter {
    func fetchPersonData(with id: Int) {
        Task {
            let ids = await getSavedFilms()
            do {
                // получаем personModelData и оттуда парсим id фильмов в которых он снимался
                let personData = try await model.getPesonData(id: id)
                var moviesPesonId: [Int] { personData.movies?.compactMap { $0.id } ?? [] }
                // запрашиваем фильмы с данными id
                let movieData = try await model.getFilmographyData(ids: moviesPesonId)
                // извлекаем нужную для нам структуру с людьми
                let personModel = PersonViewModel(personData: personData)
                let persons = personModel.items
                // получаем фильмы
                let movieModel = MovieViewModel(movieData: movieData, savedFilms: ids)
                let movies = movieModel.movies()
                // отправляем конфигурироваться view
                delegate?.configureView(with: persons, with: movies)
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
