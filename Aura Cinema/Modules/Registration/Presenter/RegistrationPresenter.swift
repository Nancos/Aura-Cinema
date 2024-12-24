protocol RegistrationViewDelegate {
    func showLoginViewController()
    func showError(title: String, message: String, alertType: AlertType)
}

final class RegistrationPresenter {
    private let service = AuthService.shared
    var delegate: RegistrationViewDelegate?
    
    func register(name: String, surname: String, email: String, password: String)  {
        let user = UserData(email: email, password: password, name: name, surname: surname)
        
        service.createNewUser(user: user) { [weak self] result in
            
            guard let `self` else { return }
            
            switch result {
            case .success(_):
                delegate?.showLoginViewController()
            case .failure(let error):
                delegate?.showError(title: String(localized: "Error"),
                                    message: error.localizedDescription(),
                                    alertType: .standardDefault)
            }
        }
    }
}
