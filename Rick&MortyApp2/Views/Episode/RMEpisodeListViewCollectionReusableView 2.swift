//
//  RMEpisodeListViewCollectionReusableView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 29.03.2025.
//

import UIKit

final class RMEpisodeListViewCollectionReusableView: UICollectionReusableView {
    
    
    static let identifier = "RMEpisodeListViewCollectionReusableView"
    
    private let spiner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        addSubview(spiner)
        SetConstains()
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func SetConstains(){
        NSLayoutConstraint.activate([
            spiner.widthAnchor.constraint(equalToConstant: 100),
            spiner.heightAnchor.constraint(equalToConstant: 100),
            spiner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spiner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    public func StartSpin(){
        spiner.startAnimating()
    }
}
