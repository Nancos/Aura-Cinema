//
//  RegistrationPresenter.swift
//  Aura Cinema
//
//  Created by MacBook Air on 24.01.25.
//

protocol RegistrationViewDelegate {
    func showLoginViewController()
    func showError(title: String, message: String, alertType: AlertType)
}

class RegistrationPresenter {
    private let service = AuthService()
    var delegate: RegistrationViewDelegate?
    
    func register(name: String, surname: String, email: String, password: String)  {
        let user = UserData(email: email, password: password, name: name, surname: surname)
        
        service.createNewUser(user: user) { [weak self] result in
            
            guard let `self` else { return }
            
            switch result {
            case .success(_):
                delegate?.showLoginViewController()
            case .failure(let failure):
                let errorMessage = self.service.switchErrorToAlert(failure)
                delegate?.showError(title: "Error",
                                    message: errorMessage,
                                    alertType: .standardDefault)
            }
        }
    }
}
