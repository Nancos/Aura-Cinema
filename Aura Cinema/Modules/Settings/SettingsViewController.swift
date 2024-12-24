//
//  SettingsViewController.swift
//  Aura Cinema
//
//  Created by MacBook Air on 16.01.25.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: - UI Elements -
    private let exitButton = UIButton()
    private let cacheLabel = UILabel()
    private let clearCacheButton = UIButton()
    
    // MARK: = Presenter -
    private let presenter = SettingsPresnter()
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        presenter.delegate = self

        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            await presenter.updateCacheSize()
        }
    }
}

private extension SettingsViewController {
    
    func setupUI() {
        setupExitButton()
        setupCacheLabel()
        setupClearCacheButton()
        
        setupConstraints()
    }
    
    func setupExitButton() {
        exitButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        exitButton.setTitle("   Exit", for: .normal)
        exitButton.setTitleColor(.systemBlue, for: .normal)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        
        view.addSubview(exitButton)
    }
    
    func setupCacheLabel() {
        cacheLabel.textColor = UIColor(named: "forLabel")
        cacheLabel.font = UIFont(name: "AvenirNext-Bold", size: 16)
        view.addSubview(cacheLabel)
    }
    
    func setupClearCacheButton() {
        clearCacheButton.backgroundColor = .systemBlue
        clearCacheButton.setTitle("Clear", for: .normal)
        clearCacheButton.setTitleColor(.white, for: .normal)
        clearCacheButton.layer.cornerRadius = 10
        clearCacheButton.addTarget(self, action: #selector(clearCacheButtonTapped), for: .touchUpInside)
        view.addSubview(clearCacheButton)
    }
    
    @objc func exitButtonTapped() {
        presenter.exit()
    }
    
    @objc func clearCacheButtonTapped() {
        Task {
            await presenter.clearCache()
        }
    }
    
    func setupConstraints() {
        exitButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        cacheLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(150)
        }
        clearCacheButton.snp.makeConstraints { make in
            make.top.equalTo(cacheLabel).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(150)
        }
    }
}

// MARK: - SettingsPresnterProtocol -
extension SettingsViewController: SettingsPresnterProtocol {
    func didUpdateCacheSize(_ size: String) {
        cacheLabel.text = "Память: \(size)"
    }
    
    func exit() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            showAlert(title: "Что-то пошло не так...", message: "Попробуйте еще раз", alertType: .standardDefault)
            return
        }
        appDelegate.setRootViewControllerToAuthScreen()
    }
}
