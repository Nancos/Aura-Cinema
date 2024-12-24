//
//  AutorizationPresenter.swift
//  Aura Cinema
//
//  Created by MacBook Air on 24.01.25.
//

protocol AuthorizationViewProtocol {
    func authSuccess()
    func showError(title: String, message: String, alertType: AlertType)
}

class AutorizationPresenter {
    private let service = AuthService()
    var delegate: AuthorizationViewProtocol?
    
    func autorizhation(email: String, password: String) {
        let user = UserData(email: email, password: password, name: nil, surname: nil)
        
        service.signIn(user: user) { [weak self] result in
            
            guard let `self` else { return }
            
            switch result {
            case .success(_):
                delegate?.authSuccess()
            case .failure(let failure):
                let errorMessage = self.service.switchErrorToAlert(failure)
                delegate?.showError(title: "Error",
                                    message: errorMessage,
                                    alertType: .standardDefault)
            }
        }
    }
}
