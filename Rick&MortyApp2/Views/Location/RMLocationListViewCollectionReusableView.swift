//
//  RMEpisodeListViewCollectionReusableView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 29.03.2025.
//

import UIKit

final class RMLocationListViewCollectionReusableView: UIView {
    
    
    static let identifier = "RMLocationListViewCollectionReusableView"
    
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
            spiner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            self.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    public func StartSpin(){
        spiner.startAnimating()
    }
}
