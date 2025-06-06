//
//  RMCharacterSelectedViewViewController.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 29.03.2025.
//

import UIKit

class RMCharacterSelectedViewViewController: UIViewController {

    let collection: RMCharacterSelectedView
    let viewModel: RMCharacterSelectedViewViewModel
     
    init(viewModel:RMCharacterSelectedViewViewModel){
        self.viewModel = viewModel
        self.collection = RMCharacterSelectedView(frame: .zero, viewModel: self.viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        collection.collectionView?.delegate = self
        collection.collectionView?.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapShare))
        
        
        SetLayout()
    }
    @objc func didTapShare(){
        
    }
    
    private func SetLayout(){
        view.addSubview(collection)
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collection.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}

extension RMCharacterSelectedViewViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionTypes = viewModel.sections[section]
        switch sectionTypes{
        case .imageScetion:
            return 1
        case .infoSection(let viewmodels):
            return viewmodels.count
        case .seriesSection(let viewmodels):
            return viewmodels.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionTypes = viewModel.sections[indexPath.section]
        switch sectionTypes{
        case .imageScetion(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterImageViewCell.Identifier,
                for: indexPath) as? RMCharacterImageViewCell else {
                fatalError()
            }
            cell.Configure(viewMOdel: viewmodels)
            
            return cell
            
        case .infoSection(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoViewCell.Identifier,
                for: indexPath) as? RMCharacterInfoViewCell else {
                fatalError()
            }
            cell.Configure(viewMOdel: viewmodels[indexPath.row])
            
            return cell
            
        case .seriesSection(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeListCellView.Identifier,
                for: indexPath) as? RMEpisodeListCellView else {
                fatalError()
            }
            cell.Configure(viewMOdel: viewmodels[indexPath.row])
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionTypes = viewModel.sections[indexPath.section]
        
        switch sectionTypes{
        case .imageScetion, .infoSection:
            return
        case .seriesSection:
            
            let episodes = viewModel.episodes
            let url = episodes[indexPath.row]
            let vc = RMEpisodesSelectedViewController(url: URL(string: url))
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
    }

}
