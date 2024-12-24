import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - UI Elements -
    private let exitButton = UIButton()
    private let cacheLabel = UILabel()
    private let clearCacheButton = UIButton()
    
    // MARK: = Presenter -
    private let presenter = SettingsPresnter()
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
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
        setupView()
        setupExitButton()
        setupCacheLabel()
        setupClearCacheButton()
        
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = .background
        presenter.delegate = self
    }
    
    func setupExitButton() {
        exitButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        exitButton.setTitle(String(localized: "exit"), for: .normal)
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
        clearCacheButton.setTitle(String(localized: "Clear"), for: .normal)
        clearCacheButton.setTitleColor(.white, for: .normal)
        clearCacheButton.layer.cornerRadius = 10
        clearCacheButton.addTarget(self, action: #selector(clearCacheButtonTapped), for: .touchUpInside)
        view.addSubview(clearCacheButton)
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

// MARK: - Private Methods-
private extension SettingsViewController {
    @objc func exitButtonTapped() {
        presenter.exit()
    }
    
    @objc func clearCacheButtonTapped() {
        Task {
            await presenter.clearCache()
        }
    }
}

// MARK: - SettingsPresnterProtocol -
extension SettingsViewController: SettingsPresnterProtocol {
    func didUpdateCacheSize(_ size: String) {
        cacheLabel.text = String(localized: "storage") + "\(size)"
    }
    
    func exit() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            showAlert(title: String(localized: "error_unknown"),
                      message: String(localized: "try_again"),
                      alertType: .standardDefault)
            return
        }
        appDelegate.setRootViewControllerToAuthScreen()
    }
}
