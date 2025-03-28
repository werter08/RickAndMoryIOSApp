//
//  RMCharackterListView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 28.03.2025.
//

import UIKit

class RMCharackterListView: UIView {

    private let characterViewModel = RMCharacterListViewViewModel()
    private let spiner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        return spinner
    }()
    
    
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false;
        backgroundColor = .systemBlue
        
        addSubview(spiner)
        SetNSConstrain()
        spiner.startAnimating()
    }

    required init?(coder: NSCoder) {
        fatalError("Unspeccted")
    }
    
    func SetNSConstrain(){
        NSLayoutConstraint.activate([
            spiner.widthAnchor.constraint(equalToConstant: 100),
            spiner.heightAnchor.constraint(equalToConstant: 100),
            spiner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spiner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
