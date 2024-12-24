import UIKit

final class DropDownTable: UIView {
    
    private var didSelectRowCompletion: ([String]?) -> () = { _ in }
    
    let tableView = UITableView()
    
    private var dropDownType: FilterType?
    
    private var items: [String] = [] // Для API
    private var displayItems: [String] = [] // Для UI

    private var selectedRows: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(items: FilterType, didSelectRowCompletion: @escaping ([String]?) -> ()) {
        let (rawValues, localizedValues) = items.allItems
        self.items = rawValues
        self.displayItems = localizedValues
        self.dropDownType = items
        self.didSelectRowCompletion = didSelectRowCompletion
        
        tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func getSizeTable() -> CGFloat {
        return tableView.contentSize.height
    }
}

private extension DropDownTable {
    func setupUI() {
        setupView()
        setupTableView()
        setupConstraints()
    }
    
    func setupView() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.separatorStyle = .none
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DropDownTable: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description()) ?? UITableViewCell()
        cell.textLabel?.text = displayItems[indexPath.row]
        cell.accessoryType = selectedRows.contains(items[indexPath.row]) ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newSelected = items[indexPath.row]
        setupSelectedRows(newSelected, tableView: tableView, indexPath: indexPath)
    }
}

// MARK: - Private Method dropdown table -
private extension DropDownTable {
    func setupSelectedRows(_ newSelected: String, tableView: UITableView, indexPath: IndexPath) {
        let selectedRawValue = items[indexPath.row]
        switch dropDownType {
        case .filterCategory:
            if selectedRows.contains(selectedRawValue) {
                selectedRows = []
                tableView.deselectRow(at: indexPath, animated: true)
                didSelectRowCompletion(nil)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                selectedRows = [selectedRawValue]
                didSelectRowCompletion([selectedRawValue])
                tableView.reloadData()
            }
        case .filterGenre, .filterCountry:
            if let index = selectedRows.firstIndex(of: selectedRawValue) {
                selectedRows.remove(at: index)
                didSelectRowCompletion(selectedRows.isEmpty ? nil : selectedRows)
                tableView.deselectRow(at: indexPath, animated: true)
            } else {
                if selectedRows.count == 3 {
                    selectedRows.removeFirst()
                }
                selectedRows.append(selectedRawValue)
                didSelectRowCompletion(selectedRows)
            }
            tableView.reloadData()
        case .none:
            break
        }
    }
}
