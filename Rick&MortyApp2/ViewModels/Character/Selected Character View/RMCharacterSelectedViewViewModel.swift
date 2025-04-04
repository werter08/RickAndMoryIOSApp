//
//  RMCharacterSelectedViewViewModel.swift.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 29.03.2025.
//

import UIKit

final class  RMCharacterSelectedViewViewModel{
    private let char:RMCharacter
    
    public var title:String
    public var sections: [sectionTypes] = []
    var episodes: [String]
    
    enum sectionTypes{
        case imageScetion(viewModel: RMCharacterImageViewCellViewModel)
        case infoSection(viewModels: [RMCharacterInfoViewCellViewModel])
        case seriesSection(viewModels: [RMEpisodeViewCellViewModel])
    }
    //public var sections:sectionTypes
    init(char: RMCharacter) {
        self.char = char
        episodes = char.episode
        title = char.name.uppercased()
        SetUpSection()

    }
    
    func SetUpSection(){
        sections = [
            .imageScetion(viewModel: .init(imageUrl: URL(string: char.image))),
            .infoSection(viewModels: [
                .init(type:.status , value: char.status.rawValue),
                .init(type:.gender, value: char.gender.rawValue),
                .init(type:.type, value: char.type),
                .init(type:.species, value: char.species),
                .init(type:.origin, value: char.origin.name),
                .init(type:.location, value: char.location.name),
                .init(type:.created, value: char.created),
                .init(type: .totalEpisodes, value: "\(char.episode.count)"),
                
                
            ]),
            .seriesSection(viewModels: char.episode.compactMap({
                return RMEpisodeViewCellViewModel(episodeUrl: URL(string: $0))
            }))
            
        ]
        
    }
    
    func createImageSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 10,
            trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.6)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
    func createInfoSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 10,
            bottom: 10,
            trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(120)),
            subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createEpisodesSection() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.5)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(200)),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
}
