//
//  RMEpisodeListView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 28.03.2025.
//

import UIKit

protocol RMEpisodeListViewDelegate: AnyObject{
    func episodeTapped(_ charListView: RMEpisodeListView,
                    episode: RMEpisode)
}

class RMEpisodeListView: UIView {
    
    


    private let episodeViewModel = RMEpisodeListViewViewModel()
    public weak var delegate:RMEpisodeListViewDelegate?
    
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints=false;
        collectionView.alpha=0
        collectionView.isHidden=true
 
       
        //givind a identificator for cells in thic grid
        collectionView.register(RMEpisodeListCellView.self,
                                forCellWithReuseIdentifier: RMEpisodeListCellView.Identifier)
        
        collectionView.register(RMEpisodeListViewCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMEpisodeListViewCollectionReusableView.identifier)
        
        return collectionView
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false;

        
     
        addSubs(collectionView, spiner)
        SetNSConstrain()
        spiner.startAnimating()
        SetUpCollectionView()
        episodeViewModel.delegate = self
        episodeViewModel.FetchEpisode()
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
        collectionView.dataSource = episodeViewModel
        collectionView.delegate = episodeViewModel
        
    }
}

extension RMEpisodeListView: RMEpisodeListtCellViewModelDelegate{
    func episodeTapped(_ charListView: RMEpisodeListView, episode: RMEpisode) {
        return
    }
    

    
    func episodeTapped(episode: RMEpisode) {
        delegate?.episodeTapped(self, episode: episode)
    }
    func NewepisodesDidLoad(with indexPath: [IndexPath]) {
        print(indexPath.count)
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: indexPath)
            print("Alles in ordnung")
        }
    }
    
    
    
    
    
    func DidLoad() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.spiner.stopAnimating()
            self.collectionView.isHidden=false
            UIView.animate(withDuration: 1){
                self.collectionView.alpha=1
            }
        }
       
    }
    
}
