import UIKit

final class TabBarViewController: UITabBarController {
    // MARK: - UI Elements -
    private var likeButton = UIButton()
    private var homeButton = UIButton()
    private var searchButton = UIButton()
    private var directoryButton = UIButton()
    private var settingsButton = UIButton()
    private var customBar = UIStackView()
    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Private Methods -
private extension TabBarViewController {
    func setupUI() {
        setupView()
        setupCustomBar()
        setupLikeButton()
        setupSearchButton()
        setupHomeButton()
        setupDirectoryButton()
        setupSettingsButton()
        
        setupConstraints()
    }
    
    func setupView() {
        tabBar.isHidden = true
        setViewControllers([HomeViewController(),
                            LikeViewController(),
                            SearchViewController(),
                            DirectoryViewController(),
                            SettingsViewController()], animated: true)
    }
    
    func setupCustomBar() {
        customBar.axis = .horizontal
        customBar.distribution = .fillEqually
        customBar.alignment = .center
        customBar.backgroundColor = UIColor(named: "TabBar")
        customBar.layer.cornerRadius = 15
        
        view.addSubview(customBar)
    }
    
    func setupHomeButton() {
        homeButton = setupButton(imageName: "house", title: String(localized: "Home"), tag: 0, opacity: 1)
        
        customBar.addArrangedSubview(homeButton)
    }
    
    func setupLikeButton() {
        likeButton = setupButton(imageName: "heart", title: String(localized: "Saved"), tag: 1, opacity: 0.3)
        
        customBar.addArrangedSubview(likeButton)
    }
    
    func setupSearchButton() {
        searchButton = setupButton(imageName: "magnifyingglass", title: String(localized: "Search"), tag: 2, opacity: 0.3)
        
        customBar.addArrangedSubview(searchButton)
    }
    
    func setupDirectoryButton() {
        directoryButton = setupButton(imageName: "tray", title: String(localized: "Directory"), tag: 3, opacity: 0.3)
        
        customBar.addArrangedSubview(directoryButton)
    }
    
    func setupSettingsButton() {
        settingsButton = setupButton(imageName: "gearshape", title: String(localized: "Settings"), tag: 4, opacity: 0.3)
        
        customBar.addArrangedSubview(settingsButton)
    }
    
    func setupConstraints() {
        customBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(50)
        }
    }
}

// MARK: - Private function -
private extension TabBarViewController {
    @objc func tapButton(_ sender: UIButton) {
        self.selectedIndex = sender.tag
        setOpacity(tag: sender.tag)
    }
    // настройка прозрачности
    func setOpacity(tag: Int) {
        [homeButton, likeButton, searchButton, directoryButton, settingsButton].forEach{
            $0.layer.opacity = Float(($0.tag == tag) ? 1 : 0.3)
        }
    }
    
    // настройка кнопки
    func setupButton(imageName: String, title: String, tag: Int, opacity: Float) -> UIButton {
        let button = UIButton(type: .custom)
        var config = UIButton.Configuration.filled()
        config.title = title
        config.image = UIImage(systemName: imageName)
        config.imagePadding = 5
        config.imagePlacement = .top
        config.titleAlignment = .center
        config.baseBackgroundColor = .clear
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 8)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer {
            $0.font(UIFont.systemFont(ofSize: 8))
        }
        button.configuration = config
        button.tag = tag
        button.layer.opacity = opacity
        button.setTitleColor(UIColor(named: "forLabel"), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }
}
