//
//  RMSerachViewModel.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import Foundation

final class RMSearchViewModel {
    
    public let config: RMSearchViewController.Config
    private var optionMap: [RMSearchInputViewModel.options : String] = [:]
    private var searchText: String = ""
    private var OptionChangeBlock: ((RMSearchInputViewModel.options, String) -> Void)?
    private var registerSearchResult: ((RMSearchResultsViewModele?) -> Void)?
 
    public var searchResultModels: Codable?
// MARK: - INIT
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    

// MARK: - PUBLIC
    func set(value: String, for option: RMSearchInputViewModel.options){
        optionMap[option] = value
        OptionChangeBlock?(option, value)
    }
    func setSearchText(text: String){
        self.searchText = text
        print(searchText)
    }
    func registerOptionChangeBlock(_ block: @escaping(RMSearchInputViewModel.options, String) -> Void){
        self.OptionChangeBlock = block
    }
    func registerSerchResultHandler(_ block:@escaping(RMSearchResultsViewModele?) -> Void){
        self.registerSearchResult = block
    }
    
// MARK: - Search Request builder
    func executeSearch(){
        //addind parametrs: search text
        var gueryParams: [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        ]
        //addind parametrs: option buttons
        gueryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key = element.key
            return URLQueryItem(name: key.querys, value: element.value)
        }))
        
        let request = RMRequest.init(endPoint: config.type.endPoints, queryParametr: gueryParams )
        
        switch config.type {
        case .location:
            callAPIResponse(request: request, RMCLocationWindow.self)
        case .episode:
            callAPIResponse(request: request, RMEpisodeWindow.self)
        case .character:
            callAPIResponse(request: request, RMCharacterWindow.self)
        }
    }
    private func callAPIResponse<T: Codable>(request: RMRequest, _ tupe: T.Type){
        RMServise.shared.Execute(request, expecting: tupe) { [weak self] res in
            switch res {
            case .success(let model):
                self?.searchResultModels = model
                self?.proccesSerachResults(model: model)
            case .failure(let failure):
                print(String(describing: failure))
                self?.noResults()
            }
        }
    }
    private func proccesSerachResults(model: Codable){
        var results: RMSearchResultsViewModele?
        
        if let characterResults = model as? RMCharacterWindow {
            results = .characters(characterResults.results.compactMap({
                return RMCharacterListtCellViewModel(name: $0.name, status: $0.status, img: URL(string: $0.image))
            }))
        } else if let locationResults = model as? RMCLocationWindow {
            results = .locations(locationResults.results.compactMap({
                return RMLocationCellViewModel(location: $0)
            }))
        } else if let episodeResults = model as? RMEpisodeWindow {
            results = .episodes(episodeResults.results.compactMap({
                return RMEpisodeViewCellViewModel(episodeUrl: URL(string: $0.url))
            }))
        }
        if let cells = results{
            self.registerSearchResult?(cells)
           
        } else {
            noResults()
        }
  
    }
    
    
    //MARK: - GETTING MODEL
    func noResults(){
        self.registerSearchResult?(nil)
    }
    
    func getLocationModel(at index: Int) -> RMLocation? {
        guard let locations = searchResultModels as? RMCLocationWindow else {
            return nil
        }
        return locations.results[index]
    }
    
    func getCharacterModel(at index: Int) -> RMCharacter? {
        guard let characters = searchResultModels as? RMCharacterWindow else {
            return nil
        }
        return characters.results[index]
        
    }
    
    func getEpisodeModel(at index: Int) -> RMEpisode? {
        guard let episodes = searchResultModels as? RMEpisodeWindow else {
            return nil
        }
        return episodes.results[index]
    }
    
}
