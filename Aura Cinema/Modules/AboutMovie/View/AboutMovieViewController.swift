//
//  AboutMoviewViewController.swift
//  Aura Cinema
//
//  Created by MacBook Air on 7.01.25.
//

import UIKit

class AboutMovieViewController: UIViewController {
    
    // MARK: - UI Elements -
    private let tableView = UITableView()
    
    // MARK: = Methods -
    private var item: ModelMovieDescriptionCell?
    
    // MARK: - Initilisation -
    init(with item: ModelMovieDescriptionCell) {
        super.init(nibName: nil, bundle: nil)
        self.item = item
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
        tableView.register(TitleCell.self, forCellReuseIdentifier: "TitleCell")
        tableView.register(ShortDescriptionCell.self, forCellReuseIdentifier: "ShortDescriptionCell")
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: "DescriptionCell")
        tableView.register(AgeRatingCell.self, forCellReuseIdentifier: "AgeRatingCell")
        
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
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = item else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
            cell.configurate(with: item.title)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ShortDescriptionCell", for: indexPath) as! ShortDescriptionCell
            cell.configure(with: item.shortDescription)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
            cell.configure(with: item.description)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgeRatingCell", for: indexPath) as! AgeRatingCell
            cell.configure(with: item.ageRating)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
