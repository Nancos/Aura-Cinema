//
//  PersonView.swift
//  Aura Cinema
//
//  Created by MacBook Air on 12.01.25.
//

import UIKit

protocol MoviePersonDelgate {
    func didTapPerson(with id: Int)
}

class PersonView: UIView {
    
    var delegate: MoviePersonDelgate?
    
    // MARK: - UI Elements -
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    // MARK: - UI Elements -
    private(set) var id = 0
    
    // MARK: - Configure -
    func configure(data: ModelMoviePersonCell) {
        imageView.kf.setImage(with: URL(string: data.personPhoto),
                              placeholder: nil,
                              options: [.transition(.fade(0.4))])
        nameLabel.text = splitNameForLabel(data.personName)
        self.id = data.personID
        addTapGesture()
    }
    
    // MARK: - Init -
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods -
private extension PersonView {
    
    func setupUI() {
        setupImageView()
        setupNameLabel()
        
        setupConstraints()
    }
    
    func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        
        addSubview(imageView)
    }
    
    func setupNameLabel() {
        nameLabel.font = .systemFont(ofSize: 12, weight: .medium)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        
        addSubview(nameLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
                
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
    }
}

// MARK: - Private function - 
private extension PersonView {
    func splitNameForLabel(_ name: String) -> String {
        return name.replacingOccurrences(of: " ", with: "\n")
    }
}

// MARK: - Gesture Tap Person -
private extension PersonView {
    func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleViewTap(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleViewTap(_ sender: UITapGestureRecognizer) {
        delegate?.didTapPerson(with: id)
    }
}
