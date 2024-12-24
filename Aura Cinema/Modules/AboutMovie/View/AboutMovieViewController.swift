import UIKit

final class AboutMovieViewController: UIViewController {
    
    // MARK: - UI Elements -
    private let tableView = UITableView()
    
    // MARK: = Methods -
    private var items: [ModelMovieDescription] = []
    
    // MARK: - Initilisation -
    init(with items: [ModelMovieDescription]) {
        super.init(nibName: nil, bundle: nil)
        self.items = items
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods -
private extension AboutMovieViewController {
    
    func setupUI() {
        setupTableView()
        
        setupConstraints()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.description())
        tableView.register(ShortDescriptionCell.self, forCellReuseIdentifier: ShortDescriptionCell.description())
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.description())
        tableView.register(AgeRatingCell.self, forCellReuseIdentifier: AgeRatingCell.description())
        
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource -
extension AboutMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        return configureTableView(item: item, indexPath: indexPath) ?? UITableViewCell()
    }
}

// MARK: - Helper configure cell's for table -
private extension AboutMovieViewController {
    
    func configureTableView(item: ModelMovieDescription, indexPath: IndexPath) -> UITableViewCell? {
        switch item {
            case .title(let model): return configureTitleCell(model, indexPath: indexPath)
            case .shortDescription(let model): return configureShortDescriptionCell(model, indexPath: indexPath)
            case .description(let model): return configureDescriptionCell(model, indexPath: indexPath)
            case .ageRating(let model): return configureAgeRatingCell(model, indexPath: indexPath)
        }
    }
    
    private func configureTitleCell(_ model: String, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.description(), for: indexPath) as? TitleCell
        cell?.configure(with: model)
        return cell
    }
    
    private func configureShortDescriptionCell(_ model: String, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShortDescriptionCell.description(), for: indexPath) as? ShortDescriptionCell
        cell?.configure(with: model)
        return cell
    }
    
    private func configureDescriptionCell(_ model: String, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.description(), for: indexPath) as? DescriptionCell
        cell?.configure(with: model)
        return cell
    }
    
    private func configureAgeRatingCell(_ model: String, indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: AgeRatingCell.description(), for: indexPath) as? AgeRatingCell
        cell?.configure(with: model)
        return cell
    }
}
