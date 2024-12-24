protocol AuthorizationViewProtocol {
    func authSuccess()
    func showError(title: String, message: String, alertType: AlertType)
}

final class AutorizationPresenter {
    private let service = AuthService.shared
    var delegate: AuthorizationViewProtocol?
    
    func autorizhation(email: String, password: String) {
        let user = UserData(email: email, password: password, name: nil, surname: nil)
        
        service.signIn(user: user) { [weak self] result in
            
            guard let `self` else { return }
            
            switch result {
            case .success(_):
                delegate?.authSuccess()
            case .failure(let error):
                delegate?.showError(title: String(localized: "Error"),
                                    message: error.localizedDescription(),
                                    alertType: .standardDefault)
            }
        }
    }
}
