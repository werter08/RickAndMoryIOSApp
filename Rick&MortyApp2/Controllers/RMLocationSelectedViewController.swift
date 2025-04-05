//
//  RMEPisodesSelectedViewController.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 02.04.2025.
//

import UIKit

class RMLocationSelectedViewController: UIViewController {

    public var model: RMLocation
    public var viewModel: RMEpisodeSelectedViewViewModel?
    private var collection: RMEpisodeSelectedView?
    
    init(model: RMLocation) {
        self.model = model
//        self.viewModel = RMEpisodeSelectedViewViewModel(url: url)
//        collection = RMEpisodeSelectedView(frame: .zero, viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        view.backgroundColor = .secondarySystemBackground
//        viewModel.fetchDate()
//       

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapShare))
        
      //  setUpConstraints()
    
    }
    @objc func didTapShare(){
        
    }
    
    
//    private func setUpConstraints(){
//        view.addSubview(collection)
//        
//        NSLayoutConstraint.activate([
//            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            collection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            collection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
    
    
//    
//    func didFetchDate() {
//        collection.Configure(viewModel:  viewModel)
//        
//        collection.collectionView?.delegate = self
//        collection.collectionView?.dataSource = self
//    }
    
}


