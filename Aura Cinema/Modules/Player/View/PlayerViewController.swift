import UIKit
import WebKit

final class PlayerViewController: UIViewController {
    
    private let webView = WKWebView()
    private let navigationBar = NavigationBarViewController()
    private let presenter = PlayerPresenter()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with urlString: String) {
        presenter.loadPlayer(with: urlString)
    }
    
    // MARK: - Methods
    func loadVideo(with url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

private extension PlayerViewController {
    
    func setupUI() {
        setupView()
        setupWebView()
        setupNavigationBar()
        setupConstraints()
    }
    
    func setupView() {
        presenter.view = self
    }
    
    func setupNavigationBar() {
        view.addSubview(navigationBar)
    }
    
    func setupWebView() {
        view.addSubview(webView)
    }
    
    func setupConstraints() {
        navigationBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        webView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension PlayerViewController: PlayerViewProtocol {
    func showPlayer(with request: URLRequest) {
        webView.load(request)
    }
    
    func showError(title: String, message: String, alertType: AlertType) {
        showAlert(title: title, message: message, alertType: alertType)
    }
}
