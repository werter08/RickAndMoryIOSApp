//
//  RMCharackterListView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 28.03.2025.
//

import UIKit

class RMCharackterListView: UIView {

    private let characterViewModel = RMCharacterListViewViewModel()
    
    
    //ui spinner whic will work at start
    private let spiner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //makeing a bg for grid
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //adding padding
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints=false;
        collectionView.alpha=0
        collectionView.isHidden=true
       
        //givind a identificator for cells in thic grid
        collectionView.register(RMCharackterListCellView.self,
                                forCellWithReuseIdentifier: RMCharackterListCellView.cellIdentifier)
        return collectionView
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false;

        
     
        addSubs(collectionView, spiner)
        SetNSConstrain()
        spiner.startAnimating()
        characterViewModel.FetchCharacters()
        SetUpCollectionView()
        
    }

    required init?(coder: NSCoder) {
        fatalError("Unspeccted")
    }
    
    
    
    
    func SetNSConstrain(){
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
    
    private func SetUpCollectionView(){
        collectionView.dataSource = characterViewModel
        collectionView.delegate = characterViewModel
        //making a timer in the end want to show a grid
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.spiner.stopAnimating()
            UIView.animate(withDuration: 1){
                self.collectionView.isHidden=false
                self.collectionView.alpha=1
            }
        })
    }
}
