//
//  RMCharacterSelectedView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 29.03.2025.
//

import UIKit

class RMCharacterSelectedView: UIView {
    
    private let viewModel: RMCharacterSelectedViewViewModel
    
    private let spiner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //makeing a bg for grid
    public var collectionView:UICollectionView?
    
    
    init(frame: CGRect, viewModel: RMCharacterSelectedViewViewModel) {
        self.viewModel = viewModel
  
        super.init(frame: frame)
        self.backgroundColor = .blue
        translatesAutoresizingMaskIntoConstraints = false
        self.collectionView = SetCollectionView()
        AddConstronts()
        
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
        collectionView.register(RMCharacterInfoViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterInfoViewCell.Identifier)
        collectionView.register(RMCharacterImageViewCell.self,
                                forCellWithReuseIdentifier: RMCharacterImageViewCell.Identifier)
        collectionView.register(RMEpisodeListCellView.self,
                                forCellWithReuseIdentifier: RMEpisodeListCellView.Identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
        
    }
    private func CreataSection(for sectionIndex:Int) -> NSCollectionLayoutSection{
        switch viewModel.sections[sectionIndex]{
            case.imageScetion:
                return viewModel.createImageSection()
        case.infoSection:
            return viewModel.createInfoSection()
        case.seriesSection:
            return viewModel.createEpisodesSection()
        }
   
    }
}

