import Foundation

protocol PlayerViewProtocol {
    func showPlayer(with request: URLRequest)
    func showError(title: String, message: String, alertType: AlertType)
}

final class PlayerPresenter {
    
    var view: PlayerViewProtocol?
    
    func loadPlayer(with stringURL: String) {
        guard let url = URL(string: stringURL) else {
            view?.showError(title: String(localized: "Error"),
                            message: String(localized: "invalide_video_url"),
                            alertType: .standardDefault)
            return
        }
        let request = URLRequest(url: url)
        
        view?.showPlayer(with: request)
    }
}
