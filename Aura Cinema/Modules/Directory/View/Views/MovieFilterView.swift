//
//  MovieSearchCollection.swift
//  Aura Cinema
//
//  Created by MacBook Air on 21.01.25.
//

import UIKit

protocol MovieFilterViewProtocol {
    func didTappedButton(table: UIView, filterId: Int, height: CGFloat)
    func didChangedFilterCategory(category: MovieСategoryItems?)
    func didChangedFilterCountry(country: [MovieCountryItems]?)
    func didChangedFilterGenre(genre: [MovieGenreItems]?)
}

class MovieFilterView: UIView{
 
    var delegate: MovieFilterViewProtocol?
    
    private let stackView = UIStackView()
    
    private let categoryButton = UIButton()
    private let genreButton = UIButton()
    private let countryButton = UIButton()
    
    private var categoryTable = CategoryDropDownTable()
    private var genreTable = GenreDropDownTable()
    private var countryTable = CountryDropDownTable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoryTable.delegate = self
        genreTable.delegate = self
        countryTable.delegate = self
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
        setupButtons(sender: categoryButton, tag: 1, title: "Категории ↓", color: UIColor(named: "forLabel"))
        
        stackView.addArrangedSubview(categoryButton)
    }
    
    func setupGenreButton() {
        setupButtons(sender: genreButton, tag: 2, title: "Жанры ↓", color: UIColor(named: "forLabel"))
        
        stackView.addArrangedSubview(genreButton)
    }
    
    func setupCountryButton() {
        setupButtons(sender: countryButton, tag: 3, title: "Страны ↓", color: UIColor(named: "forLabel"))
        
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
        let table: UIView
        let height: CGFloat
        
        switch sender.tag {
        case 1:
            categoryTable.configure()
            height = categoryTable.getSizeTable()
            table = categoryTable
        case 2:
            genreTable.configure()
            height = genreTable.getSizeTable()
            table = genreTable
        case 3:
            countryTable.configure()
            height = countryTable.getSizeTable()
            table = countryTable
        default:
            return
        }
        delegate?.didTappedButton(table: table, filterId: sender.tag, height: height)
    }
}

// MARK: = CategoryDropDownTableDelegate -
extension MovieFilterView: CategoryDropDownTableDelegate {
    func didSelectCategory(_ category: MovieСategoryItems?) {
        delegate?.didChangedFilterCategory(category: category)
    }
}

// MARK: = CountryDropDownTableDelegate -
extension MovieFilterView: CountryDropDownTableDelegate {
    func didSelectCountry(_ country: [MovieCountryItems]?) {
        delegate?.didChangedFilterCountry(country: country)
    }
}

// MARK: = GenreDropDownTableDelegate -
extension MovieFilterView: GenreDropDownTableDelegate {
    func didSelectGenre(_ genre: [MovieGenreItems]?) {
        delegate?.didChangedFilterGenre(genre: genre)
    }
}
