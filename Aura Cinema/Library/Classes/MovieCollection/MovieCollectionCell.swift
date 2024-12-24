import UIKit

final class MovieCollectionCell: UICollectionViewCell {
    
    let movieView = MovieView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: MovieViewData,
                   filmography: String?,
                   tapViewCompletion: @escaping (Int) -> Void,
                   doubleTapViewCompletion: @escaping (Int) -> Void) {
        movieView.configure(with: data,
                            filmography: filmography,
                            tapViewCompletion: tapViewCompletion,
                            doubleTapViewCompletion: doubleTapViewCompletion)
        
    }
}

private extension MovieCollectionCell {
    func setupUI() {
        contentView.addSubview(movieView)
        setupConstraint()
    }
    
    func setupConstraint() {
        movieView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
