//
//  DropDownTable.swift
//  Aura Cinema
//
//  Created by MacBook Air on 21.01.25.
//
import UIKit

protocol CategoryDropDownTableDelegate: AnyObject {
    func didSelectCategory(_ category: MovieСategoryItems?)
}

class CategoryDropDownTable: UIView {
    
    var delegate: CategoryDropDownTableDelegate?
    
    let tableView = UITableView()
    private var items: [MovieСategoryItems] = MovieСategoryItems.allCases
    private var selectedRow: MovieСategoryItems?
    
    func configure() {
        tableView.reloadData()
        DispatchQueue.main.async {
            if self.tableView.numberOfSections > 0, self.tableView.numberOfRows(inSection: 0) > 0 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    func getSizeTable() -> CGFloat {
        return tableView.contentSize.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CategoryDropDownTable {
    func setupUI() {
        layer.cornerRadius = 10
        clipsToBounds = true
        setupTableView()
        setupConstraints()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CategoryDropDownTable: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        let item = items[indexPath.row]
        cell.textLabel?.text = item.rawValue
        cell.accessoryType = (selectedRow == item) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newSelected = items[indexPath.row]
        
        if newSelected == selectedRow {
            selectedRow = nil
            tableView.deselectRow(at: indexPath, animated: true)
            delegate?.didSelectCategory(nil)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            // Запоминаем старый выбранный элемент
            let oldSelectedIndexPath = selectedRow.flatMap {
                items.firstIndex(of: $0).map { IndexPath(row: $0, section: 0) }
            }
            // Обновляем выбранный элемент
            selectedRow = newSelected
            delegate?.didSelectCategory(newSelected)
            // Перезагружаем строки: старую и новую
            var indexPathsToUpdate: [IndexPath] = [indexPath]
            if let oldSelectedIndexPath {
                indexPathsToUpdate.append(oldSelectedIndexPath)
            }
            tableView.reloadRows(at: indexPathsToUpdate, with: .automatic)
        }
    }
}
