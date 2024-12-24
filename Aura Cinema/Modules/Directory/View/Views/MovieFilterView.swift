import UIKit

protocol MovieFilterViewProtocol {
    func didTappedButton(table: UIView, filterId: Int, height: CGFloat)
    func didChangedFilterCategory(category: MovieСategoryItems?)
    func didChangedFilterCountry(country: [MovieCountryItems]?)
    func didChangedFilterGenre(genre: [MovieGenreItems]?)
}

final class MovieFilterView: UIView{
 
    var delegate: MovieFilterViewProtocol?
    
    private let stackView = UIStackView()
    
    private let categoryButton = UIButton()
    private let genreButton = UIButton()
    private let countryButton = UIButton()
    
    private var dropDownTables: [Int: (DropDownTable, FilterType)] {
        return [
            1: (categoryTable, .filterCategory),
            2: (genreTable, .filterGenre),
            3: (countryTable, .filterCountry)
        ]
    }
    
    lazy var categoryTable = DropDownTable()
    lazy var genreTable = DropDownTable()
    lazy var countryTable = DropDownTable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private extension MovieFilterView {
    func setupUI() {
        setupStackView()
        setupCategoryButton()
        setupGenreButton()
        setupCountryButton()
        
        setupConstraints()
    }
    
    func setupStackView() {
        stackView.isUserInteractionEnabled = true
        stackView.backgroundColor = .background
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.layer.borderColor = UIColor.systemGray2.cgColor
        stackView.layer.borderWidth = 1
        addSubview(stackView)
    }
    
    func setupCategoryButton() {
        setupButtons(sender: categoryButton, tag: 1, title: String(localized: "category_button_title"), color: UIColor(named: "forLabel"))
        
        stackView.addArrangedSubview(categoryButton)
    }
    
    func setupGenreButton() {
        setupButtons(sender: genreButton, tag: 2, title: String(localized: "genre_button_title"), color: UIColor(named: "forLabel"))
        
        stackView.addArrangedSubview(genreButton)
    }
    
    func setupCountryButton() {
        setupButtons(sender: countryButton, tag: 3, title: String(localized: "country_button_title"), color: UIColor(named: "forLabel"))
        
        stackView.addArrangedSubview(countryButton)
    }
    
    func setupButtons(sender: UIButton, tag: Int, title: String, color: UIColor?) {
        sender.tag = tag
        sender.setTitle(title, for: .normal)
        sender.setTitleColor(color, for: .normal)
        sender.titleLabel?.textAlignment = .center
        sender.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        sender.isUserInteractionEnabled = true
        sender.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

private extension MovieFilterView {
    @objc func tappedButton(_ sender: UIButton) {
        guard let (table, filterType) = dropDownTables[sender.tag] else { return }
        
        table.configure(items: filterType) { [weak self] selectedItems in
            self?.handleSelection(for: sender.tag, selectedItems: selectedItems)
        }
        
        delegate?.didTappedButton(table: table, filterId: sender.tag, height: table.getSizeTable())
    }
    
    private func handleSelection(for tag: Int, selectedItems: [String]?) {
        switch tag {
        case 1:
            delegate?.didChangedFilterCategory(category: MovieСategoryItems(rawValue: selectedItems?.first ?? ""))
        case 2:
            delegate?.didChangedFilterGenre(genre: selectedItems?.compactMap { MovieGenreItems(rawValue: $0) })
        case 3:
            delegate?.didChangedFilterCountry(country: selectedItems?.compactMap { MovieCountryItems(rawValue: $0) })
        default:
            break
        }
    }
}
