//
//  AuthorizationViewController.swift
//  Aura Cinema
//
//  Created by MacBook Air on 15.01.25.
//

import UIKit

class AuthorizationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI Elements -
    private let authorizationLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let registerButton = UIButton()
    
    // MARK: - Presenter -
    private let presenter = AutorizationPresenter()
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        presenter.delegate = self
        setupUI()
    }
}

extension AuthorizationViewController {
    func setupUI() {
        setupAuthorizationLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupRegisterButton()
        
        setupConstraints()
    }
    
    func setupAuthorizationLabel() {
        authorizationLabel.text = "Авторизация"
        authorizationLabel.font = .systemFont(ofSize: 24)
        
        view.addSubview(authorizationLabel)
    }
    
    func setupEmailTextField() {
        emailTextField.delegate = self
        emailTextField.placeholder = "Логин"
        emailTextField.borderStyle = .roundedRect
        
        view.addSubview(emailTextField)
    }
    
    func setupPasswordTextField() {
        passwordTextField.delegate = self
        passwordTextField.placeholder = "Пароль"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        
        view.addSubview(passwordTextField)
    }
    
    func setupLoginButton() {
        loginButton.setTitle("Войти", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 14)
        loginButton.layer.cornerRadius = 8
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitleColor(.background, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)

        view.addSubview(loginButton)
    }
    
    func setupRegisterButton() {
        registerButton.setTitle("Нет аккаунта? Зарегистрироваться", for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 12)
        registerButton.backgroundColor = .background
        registerButton.setTitleColor(.systemGray, for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonPresed), for: .touchUpInside)
        
        view.addSubview(registerButton)
    }
    
    func setupConstraints() {
        authorizationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(authorizationLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        registerButton.snp.makeConstraints{ make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // при нажатии enter закрываем клавиатуру
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) // Закрываем клавиатуру при нажатии на пустое место
    }
}

private extension AuthorizationViewController {
    @objc func loginButtonPressed() {
        presenter.autorizhation(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @objc func registerButtonPresed() {
        let registrationVC = RegistrationViewController()
        registrationVC.delegate = self
        navigationController?.pushViewController(registrationVC, animated: true)
    }
}

// MARK: - RegistrationDelegate -
extension AuthorizationViewController: RegistrationDelegate {
    func didRegisterUser(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
}


// MARK: - AutorizationProtocol -
extension AuthorizationViewController: AuthorizationViewProtocol {
    func authSuccess(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            showAlert(title: "Что-то пошло не так...", message: "Попробуйте еще раз", alertType: .standardDefault)
            return
        }
        appDelegate.setRootViewControllerToMainScreen()
    }
    
    func showError(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message,alertType: alertType)
    }
}
