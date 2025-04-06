//
//  RMNoSearchView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import UIKit
protocol RMSearchResultViewDelegate: AnyObject {
    func getTappedLocationCell(_ view: RMSearchResultView,at index: Int)
    func getTappedCharacterCell(_ view: RMSearchResultView,at index: Int)
    func getTappedEpisodeCell(_ view: RMSearchResultView,at index: Int)
}


class RMSearchResultView: UIView, UITableViewDelegate {

    weak var delegate: RMSearchResultViewDelegate?
    
    private var viewModel: RMSearchResultsViewModele? {
        didSet {
            DispatchQueue.main.async {
                self.setCells()
                UIView.animate(withDuration: 0.3) {
                    self.alpha = 1
                }
                
            }
           
        }
    }
    
    //MARK: - UI
    
    private var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        table.register(RMLocationCellView.self, forCellReuseIdentifier: RMLocationCellView.identifier)
        return table
    }()
    
    //makeing a bg for grid
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //adding padding
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints=false;
        collectionView.isHidden=true
 

        //givind a identificator for cells in thic grid
        collectionView.register(RMCharackterListCellView.self,
                                forCellWithReuseIdentifier: RMCharackterListCellView.cellIdentifier)
        collectionView.register(RMEpisodeListCellView.self,
                                forCellWithReuseIdentifier: RMEpisodeListCellView.Identifier)
        collectionView.register(RMCharacterListViewCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMCharacterListViewCollectionReusableView.identifier)
        
        return collectionView
    }()
    
    
    
    //MARK: - CELLS
    private var locationCellViewModels: [RMLocationCellViewModel] = []
    
    private var collectionCellViewModels: [any Equatable] = []
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        alpha = 0
        isHidden = true
        addSubs(tableView, collectionView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    
    //MARK: - Configure
    func configure(viewModel: RMSearchResultsViewModele){
        self.viewModel = viewModel

    }
    
    //MARK: - SET UP UI
    func setCells() {
        guard let viewModel  else {
            fatalError()
        }
        switch viewModel {
        case.characters(let cells):
            setUpCollectionView(cells: cells)
            break
        case.episodes(let cells):
            setUpCollectionView(cells: cells)
      
            break
        case.locations(let cells):
            setUpTableView(cells: cells)
            break
        }
    }
    private func setUpTableView(cells: [RMLocationCellViewModel]){
        collectionView.isHidden = true
        
        tableView.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        locationCellViewModels = cells
        tableView.reloadData()
    }
    
    private func setUpCollectionView(cells: [any Equatable]){
        tableView.isHidden = true
        
        collectionView.isHidden = false
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionCellViewModels = cells
        collectionView.reloadData()
    }
}


//MARK: - TABLE VIEW

extension RMSearchResultView: UITextViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationCellView.identifier, for: indexPath) as? RMLocationCellView else {
            fatalError("cant get locationCell")
        }
        cell.configure(module: locationCellViewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.getTappedLocationCell(self, at: indexPath.row)
    }
    
}

//MARK: - COLLECCTION VIEW
extension RMSearchResultView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentModel = collectionCellViewModels[indexPath.row]
        
        if let charVM = currentModel as? RMCharacterListtCellViewModel {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharackterListCellView.cellIdentifier,
                for: indexPath) as? RMCharackterListCellView else {
                fatalError()
            }
            cell.Configure(with: charVM)
            return cell
        }
        
        if let episodeVM = currentModel as? RMEpisodeViewCellViewModel {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeListCellView.Identifier,
                for: indexPath) as? RMEpisodeListCellView else {
                fatalError()
            }
            cell.Configure(viewMOdel: episodeVM)
            return cell
        }
        
        
        
        fatalError()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let currentModel = collectionCellViewModels[indexPath.row]
        if currentModel is RMCharacterListtCellViewModel {
            delegate?.getTappedCharacterCell(self, at: indexPath.row)
        }
        delegate?.getTappedEpisodeCell(self, at: indexPath.row)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentModel = collectionCellViewModels[indexPath.row]
        if currentModel is RMCharacterListtCellViewModel {
            let width = (UIScreen.main.bounds.width-30)/2
            return CGSize(width: width, height: width*1.5)
        }
        let width = (UIScreen.main.bounds.width-30)
        return CGSize(width: width, height: 150)
    }
}
