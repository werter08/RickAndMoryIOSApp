//
//  RMSearchViewController.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import UIKit

class RMSearchViewController: UIViewController {
    
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
            
            var endPoints: RMEndPoint {
                switch self {
                case .character: .character
                case .location: .location
                case .episode: .episode
                }
            }
            
       
            
        }
        
            
        let type: `Type`
    }

    private var viewModel: RMSearchViewModel
    private var contentView: RMSearchView
    
    
    
    //MARK: - Init
    
    init(config: Config) {
        viewModel = RMSearchViewModel(config: config)
        contentView = RMSearchView(viewmodel: viewModel)
        
        super.init(nibName: nil, bundle: nil)
        contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        setUpConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(tapExecuteSearch))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.presentkeyboard()
    }
    
    @objc private func tapExecuteSearch(){
        viewModel.executeSearch()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}


extension RMSearchViewController: RMSearchViewDelegate {
    func didTappedCharacterCell(_ view: RMSearchView, model: RMCharacter) {
        let vm = RMCharacterSelectedViewViewModel(char: model)
        let vc = RMCharacterSelectedViewViewController(viewModel: vm)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTappedEpisodeCell(_ view: RMSearchView, model: RMEpisode) {
        let vc = RMEpisodesSelectedViewController(url: URL(string: model.url))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTappedLocationCell(_ view: RMSearchView, model: RMLocation) {
        let vc = RMLocationSelectedViewController(model: model)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didInputOptionsSelected(_ view: RMSearchInputView, option: RMSearchInputViewModel.options) {
      
        let vc = RMSearchOptionViewController(option: option, selection: { [weak self] section in
            self?.viewModel.set(value: section, for: option)
        })
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
    
    
}

