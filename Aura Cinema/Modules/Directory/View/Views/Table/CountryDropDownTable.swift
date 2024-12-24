//
//  CountryDropDownTable.swift
//  Aura Cinema
//
//  Created by MacBook Air on 22.01.25.
//
import UIKit

protocol CountryDropDownTableDelegate: AnyObject {
    func didSelectCountry(_ counry: [MovieCountryItems]?)
}

class CountryDropDownTable: UIView {
    
    var delegate: CountryDropDownTableDelegate?
    
    let tableView = UITableView()
    private var items: [MovieCountryItems] = MovieCountryItems.allCases
    private var selectedRows: [MovieCountryItems] = []
    
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

private extension CountryDropDownTable {
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

extension CountryDropDownTable: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        let item = items[indexPath.row]
        cell.textLabel?.text = item.rawValue
        cell.accessoryType = selectedRows.contains(item) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        
        if let index = selectedRows.firstIndex(of: selectedItem) {
            // Если элемент уже выбран, снимаем его выбор
            selectedRows.remove(at: index)
            delegate?.didSelectCountry(selectedRows.isEmpty ? nil : selectedRows)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            // Если новый элемент, добавляем его
            if selectedRows.count == 3 {
                // Удаляем самый старый элемент, если уже 3 в массиве
                selectedRows.removeFirst()
            }
            selectedRows.append(selectedItem)
            delegate?.didSelectCountry(selectedRows)
        }
        // Обновляем интерфейс
        tableView.reloadData()
    }
}
