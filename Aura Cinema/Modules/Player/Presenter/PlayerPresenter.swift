//
//  PlayerPresenter.swift
//  Aura Cinema
//
//  Created by MacBook Air on 26.01.25.
//

import Foundation

protocol PlayerViewProtocol {
    func showPlayer(with request: URLRequest)
    func showError(title: String, message: String, alertType: AlertType)
}

class PlayerPresenter {
    
    var view: PlayerViewProtocol?
    
    func loadPlayer(with stringURL: String) {
        guard let url = URL(string: stringURL) else {
            view?.showError(title: "Ошибка",
                            message: "Невозможно отобразить видео. Некорректный URL",
                            alertType: .standardDefault)
            return
        }
        let request = URLRequest(url: url)
        
        view?.showPlayer(with: request)
    }
}
