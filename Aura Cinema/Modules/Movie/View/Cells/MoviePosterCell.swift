//import UIKit
//
//final class MoviePosterCell: UITableViewCell {
//    // MARK: - UI Elements -
//    private let posterImageView = CustomImageView()
//    
//    // MARK: - Init -
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Configure -
//    func configure(with data: ModelMoviePosterCell) {
//        posterImageView.urlString = data.posterURL
//    }
//}
//
//// MARK: - Private Methods -
//private extension MoviePosterCell {
//    
//    func setupUI() {
//        setupPosterView()
//        
//        setupConstraints()
//    }
//    
//    func setupPosterView() {
//        posterImageView.contentMode = .scaleAspectFit
//        
//        addSubview(posterImageView)
//    }
//    
//    func setupConstraints() {
//        posterImageView.snp.makeConstraints { make in
//            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5) // устанавливаем соотношение сторон
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
//    }
//}
