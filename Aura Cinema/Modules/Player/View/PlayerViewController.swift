import UIKit
import WebKit

class PlayerViewController: UIViewController {
    
    private let webView = WKWebView()
    private let navigationBar = NavigationBarViewController()
    private let presenter = PlayerPresenter()
    
    func configure(with urlString: String) {
        presenter.loadPlayer(with: urlString)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter.view = self
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - YouTubePlayerViewProtocol Methods
    func loadVideo(with url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

private extension PlayerViewController {
    
    func setupUI() {
        setupWebView()
        setupNavigationBar()
        setupConstraints()
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
