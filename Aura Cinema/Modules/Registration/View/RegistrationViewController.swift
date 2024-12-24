//
//  RegistrationViewController.swift
//  Aura Cinema
//
//  Created by MacBook Air on 16.01.25.
//

import UIKit

protocol RegistrationDelegate {
    func didRegisterUser(title: String, message: String, alertType: AlertType)
}

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI Elements -
    private let authorizationLabel = UILabel()
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let registerButton = UIButton()
    
    // MARK: = Presenter -
    private let presenter = RegistrationPresenter()
    
    // MARK: - Delegate -
    var delegate: RegistrationDelegate?
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        presenter.delegate = self
        
        setupUI()
    }
    
    // закрытие клавиатуры нажатием на enter
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // закрытие клавиатуры нажатием на пустое поле
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

private extension RegistrationViewController {
    func setupUI() {
        setupAuthorizationLabel()
        setupNameTextField()
        setupSurnameTextField()
        setupEmailTextFiled()
        setupPasswordTextField()
        setupRegisterButton()
        
        setupConstraints()
    }
    
    func setupAuthorizationLabel() {
        authorizationLabel.text = "Регистрация"
        authorizationLabel.font = .systemFont(ofSize: 24)
        
        view.addSubview(authorizationLabel)
    }
    
    func setupNameTextField() {
        nameTextField.delegate = self
        nameTextField.placeholder = "Имя"
        nameTextField.borderStyle = .roundedRect
        
        view.addSubview(nameTextField)
    }
    
    func setupSurnameTextField() {
        surnameTextField.delegate = self
        surnameTextField.placeholder = "Фамилия"
        surnameTextField.borderStyle = .roundedRect
        
        view.addSubview(surnameTextField)
    }
    
    func setupEmailTextFiled() {
        emailTextField.delegate = self
        emailTextField.placeholder = "Почта"
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
    
    func setupRegisterButton() {
        registerButton.setTitle("Регистрация", for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 14)
        registerButton.layer.cornerRadius = 8
        registerButton.backgroundColor = .systemBlue
        registerButton.setTitleColor(.background, for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)

        view.addSubview(registerButton)
    }
    
    func setupConstraints() {
        authorizationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(authorizationLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
    }
}

// MARK: - Private Methods -
private extension RegistrationViewController {
    @objc func registerButtonPressed() {
        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            showAlert(title: "Внимание!", message: "Заполните все поля", alertType: .standardDefault)
            return
        }
        
        presenter.register(name: name, surname: surname, email: email, password: password)
    }
}

// MARK: - RegistrationViewDelegate -
extension RegistrationViewController: RegistrationViewDelegate {
    func showLoginViewController() {
        self.navigationController?.popToRootViewController(animated: true)
        delegate?.didRegisterUser(title: "Регистрация прошла успешно!",
                                  message: "Пожалуйста подтвердите почту",
                                  alertType: .standardDefault)
    }
    
    func showError(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: .standardDefault)
    }
}
