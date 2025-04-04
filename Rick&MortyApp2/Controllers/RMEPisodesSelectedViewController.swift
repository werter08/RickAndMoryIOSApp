//
//  RMEPisodesSelectedViewController.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 02.04.2025.
//

import UIKit

class RMEpisodesSelectedViewController: UIViewController, RMEpisodeViewCellViewModelDelegate {


    public let viewModel: RMEpisodeSelectedViewViewModel
    private let collection: RMEpisodeSelectedView
    
    init(url: URL?) {
        self.viewModel = RMEpisodeSelectedViewViewModel(url: url)
        collection = RMEpisodeSelectedView(frame: .zero, viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .secondarySystemBackground
        viewModel.fetchDate()
        viewModel.delegate = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapShare))
        
        setUpConstraints()
    
    }
    @objc func didTapShare(){
        
    }
    
    
    private func setUpConstraints(){
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    
    func didFetchDate() {
        collection.Configure(viewModel:  viewModel)
        
        collection.collectionView?.delegate = self
        collection.collectionView?.dataSource = self
    }
    
}



extension RMEpisodesSelectedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionTypes = viewModel.sections[section]
        switch sectionTypes{
       
        case .infoSection(let viewmodels):
            return viewmodels.count
        case .chars(let viewmodels):
            return viewmodels.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionTypes = viewModel.sections[indexPath.section]
        switch sectionTypes{
        case .infoSection(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeInfoViewCell.Identifier,
                for: indexPath) as? RMEpisodeInfoViewCell else {
                fatalError()
            }
            
            cell.Configure(viewMOdel: viewmodels[indexPath.row])

            return cell
            
        case .chars(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharackterListCellView.cellIdentifier,
                for: indexPath) as? RMCharackterListCellView else {
                fatalError()
            }
            cell.Configure(with: viewmodels[indexPath.row])
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionTypes = viewModel.sections[indexPath.section]
        
        switch sectionTypes{
        case  .infoSection:
            return
        case .chars(_):
            let charModel = viewModel.getCharModel(index: indexPath.row)
            
            let vc = RMCharacterSelectedViewViewController(viewModel:  RMCharacterSelectedViewViewModel(char: charModel!))
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
    }

}
