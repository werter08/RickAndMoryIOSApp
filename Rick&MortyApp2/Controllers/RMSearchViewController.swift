//
//  RMSearchViewController.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import UIKit

class RMSearchViewController: UIViewController {

    
    private var viewModel: RMSearchViewModel
    private var contentView: RMSearchView
    
    
    struct Config {
        enum `Type` {
            case location
            case episode
            case character
            
            var title:String {
                switch self {
                case .character: "Character search"
                case .location: "Location search"
                case .episode: "Episode search"
                }
            }
        }
        let type: `Type`
        
        
    }
    private var config: Config
    
    init(config: Config) {
        self.config = config
        viewModel = RMSearchViewModel(config: config)
        contentView = RMSearchView(viewmodel: viewModel)
        super.init(nibName: nil, bundle: nil)
        view.addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = .systemBackground
        
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

