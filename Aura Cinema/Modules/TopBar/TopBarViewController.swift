//
//  TopBarViewController.swift
//  Aura Cinema
//
//  Created by MacBook Air on 27.01.25.
//

import UIKit

class NavigationBarViewController: UINavigationBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NavigationBarViewController {
    
    func setupUI() {
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor(named: "Background")
    }
}

