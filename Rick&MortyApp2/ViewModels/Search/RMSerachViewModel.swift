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
    private var registerSearchResult: ((RMSearchResultsViewModel?) -> Void)?
 

    
    public var locations: [RMLocation] = []
    public var characters: [RMCharacter] = []
    public var episodes: [RMEpisode] = []
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
    func registerSerchResultHandler(_ block:@escaping(RMSearchResultsViewModel?) -> Void){
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

                
                if let model = model as? RMCLocationWindow {
                    self?.locations.append(contentsOf: model.results)
                }
                if let model = model as? RMCharacterWindow {
                    self?.characters.append(contentsOf: model.results)
                }
                if let model = model as? RMEpisodeWindow {
                    self?.episodes.append(contentsOf: model.results)
                }
                
                
                self?.proccesSerachResults(model: model)
            case .failure(let failure):
                print(String(describing: failure))
                self?.noResults()
            }
        }
    }
    private func proccesSerachResults(model: Codable){
        var results: RMSearchResultsType?
        var nextUrl: String?
        if let characterResults = model as? RMCharacterWindow {
            results = .characters(characterResults.results.compactMap({
                return RMCharacterListtCellViewModel(name: $0.name, status: $0.status, img: URL(string: $0.image))
                })
            )
            nextUrl = characterResults.info.next
        }
        else if let locationResults = model as? RMCLocationWindow {
            results = .locations(locationResults.results.compactMap({
                return RMLocationCellViewModel(location: $0)
                })
            )
            nextUrl = locationResults.info.next
        }
        else if let episodeResults = model as? RMEpisodeWindow {
            results = .episodes(episodeResults.results.compactMap({
                return RMEpisodeViewCellViewModel(episodeUrl: URL(string: $0.url))
                })
            )
            nextUrl = episodeResults.info.next
        }
        if let cells = results{
            self.registerSearchResult?(RMSearchResultsViewModel(results: results, next: nextUrl))
           
        } else {
            noResults()
        }
  
    }
    
    
    //MARK: - GETTING MODEL
    func noResults(){
        self.registerSearchResult?(nil)
    }
    
    func getLocationModel(at index: Int) -> RMLocation? {
        
        return locations[index]
    }
    
    func getCharacterModel(at index: Int) -> RMCharacter? {
        
        return characters[index]
        
    }
    
    func getEpisodeModel(at index: Int) -> RMEpisode? {
        
        return episodes[index]
    }
    
}
