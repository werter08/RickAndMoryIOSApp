//
//  RMEPisodesSelectedViewViewModel.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 02.04.2025.
//

import UIKit

protocol RMEpisodeViewCellViewModelDelegate{
    func didFetchDate()
}

class RMEpisodeSelectedViewViewModel {

    let url: URL?
    private var episode:RMEpisode?
    
  
    public var sections: [sectionTypes] = []
    var characters: [RMCharacter] = []

    
    
    public var delegate: RMEpisodeViewCellViewModelDelegate?
    private var dateChars: (RMEpisode, [RMCharacter])?{
        didSet{
            delegate?.didFetchDate()
        }
    }
    
    
    
    init(url: URL?) {
        self.url = url
        
    }
    
    
    public func fetchDate(){
        guard let url, let request = RMRequest.init(url: url.absoluteString) else{
            return
        }
        
        RMServise.shared.Execute(
            request,
            expecting: RMEpisode.self) { Result in
            switch Result {
            case .success(let success):
                print(String(describing: success))
                self.episode = success
                self.fetchChars(model: success)
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
        
    }
    
    private func fetchChars(model: RMEpisode){
        let requests:[RMRequest] = (model.characters.compactMap({
            return RMRequest.init(url: $0)
        }))
        
        //take all chars from api and callback when all will ready
        let group = DispatchGroup()
        var chars: [RMCharacter] = []
        for request in requests {
            group.enter()
            RMServise.shared.Execute(request, expecting: RMCharacter.self) { Result in
                defer {
                    group.leave()
                }
                switch Result {
                case .success(let success):
                    chars.append(success)
                case .failure(_):
                    break
                }
            }
        }
        group.notify(queue: .main) {
            self.dateChars = (
                model,
                chars
            )
        }
        
    }
    public func getCharModel(index: Int) -> RMCharacter?{
         return dateChars?.1[index]
    }
}

extension  RMEpisodeSelectedViewViewModel{
    
    enum sectionTypes{
        case infoSection(viewModels: [RMEpisodeInfoViewCellViewModel])
        case chars(viewModels: [RMCharacterListtCellViewModel])
    }
    //public var sections:sectionTypes

    
    func SetUpSection(){
        guard let episode else{
            return
        }
        let chs = dateChars?.1
        sections = [
            .infoSection(viewModels: [
                .init(type: .name, value: episode.name),
                .init(type: .episode, value: episode.episode),
                .init(type: .air_date, value: episode.air_date),
                .init(type: .totalCharacter, value: "\(episode.characters.count)")
            ]),
            .chars(viewModels: (chs?.compactMap({
                return RMCharacterListtCellViewModel(name: $0.name, status: $0.status, img: URL(string: $0.image))
            }))!)

            
        ]
        
        
    }
    
   
    
    func createInfoSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 0,
            trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(120)),
            subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createCharsSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(300)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
}

