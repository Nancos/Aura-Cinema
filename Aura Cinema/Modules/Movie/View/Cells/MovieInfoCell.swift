import UIKit

final class MovieInfoCell: UITableViewCell {
    // MARK: - UI Elements -
    private let ratingKP = UILabel()
    private let releaseYearLabel = UILabel()
    private let genreLabel = UILabel()
    private let countryLabel = UILabel()
    private let lengthLabel = UILabel()
    private let ageRatingLabel = UILabel()
    
    // MARK: - Init -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure -
    func configure(with data: ModelMovieInfoCell) {
        ratingKP.text = data.ratingKP
        releaseYearLabel.text = data.ageRating
        genreLabel.text = data.genres
        countryLabel.text = data.countries
        lengthLabel.text = data.length
        ageRatingLabel.text = data.ageRating
    }
}

// MARK: - Private Methods -
private extension MovieInfoCell {
    
    func setupUI() {
        setupView()
        setupRatingKP()
        setupReleaseYearLabel()
        setupGenreLabel()
        setupCountryLabel()
        setupLengthLabel()
        setupAgeRatingLabel()
        
        setupConstraints()
    }
    
    func setupView() {
        selectionStyle = .none
    }
    
    func setupRatingKP() {
        ratingKP.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        addSubview(ratingKP)
    }
    
    func setupReleaseYearLabel() {
        releaseYearLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        addSubview(releaseYearLabel)
    }
    
    func setupGenreLabel() {
        genreLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        genreLabel.textAlignment = .center
        
        addSubview(genreLabel)
    }
    
    func setupCountryLabel() {
        countryLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        countryLabel.textAlignment = .center
        
        addSubview(countryLabel)
    }
    
    func setupLengthLabel() {
        lengthLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        addSubview(lengthLabel)
    }
    
    func setupAgeRatingLabel() {
        ageRatingLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        addSubview(ageRatingLabel)
    }
    
    func setupConstraints() {
        ratingKP.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
        
        releaseYearLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ratingKP.snp.bottom)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(releaseYearLabel.snp.bottom)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(genreLabel.snp.bottom)
        }
        
        lengthLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(countryLabel.snp.bottom)
        }
        
        ageRatingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lengthLabel.snp.bottom)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
