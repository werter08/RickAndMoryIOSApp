//
//  RMEpisodeSelectedView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 29.03.2025.
//

import UIKit

class RMEpisodeSelectedView: UIView {
    
    private var viewModel: RMEpisodeSelectedViewViewModel
    
    private let spiner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //makeing a bg for grid
    public var collectionView:UICollectionView?

    
    init(frame: CGRect, viewModel: RMEpisodeSelectedViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        
  
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func AddConstronts(){
        guard let collectionView else{
            return
        }
        addSubs(collectionView, spiner)
        NSLayoutConstraint.activate([
            spiner.widthAnchor.constraint(equalToConstant: 100),
            spiner.heightAnchor.constraint(equalToConstant: 100),
            spiner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spiner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func SetCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.CreataSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMEpisodeInfoViewCell.self,
                                forCellWithReuseIdentifier: RMEpisodeInfoViewCell.Identifier)
        collectionView.register(RMCharackterListCellView.self,
                                forCellWithReuseIdentifier: RMCharackterListCellView.cellIdentifier)
     
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
        
        
    }
    private func CreataSection(for sectionIndex:Int) -> NSCollectionLayoutSection{
        
        switch viewModel.sections[sectionIndex]{
        case.infoSection:
            return viewModel.createInfoSection()
        case.chars:
            return viewModel.createCharsSection()
        }
   
    }
    public func Configure(viewModel: RMEpisodeSelectedViewViewModel){
        self.viewModel = viewModel
        self.collectionView = SetCollectionView()
        AddConstronts()
        self.viewModel.SetUpSection()
        
    }
}

