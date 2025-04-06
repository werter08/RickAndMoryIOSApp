//
//  RMSearchresultsViewModel.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 06.04.2025.
//

import Foundation

protocol RMSearchResultsViewModelDelegate {
//    func updateModels(_ viewModel: RMSearchResultsViewModel, results: T.Type)
}

final class RMSearchResultsViewModel {
    var results: RMSearchResultsType?
    var next: String?
    var delegate: RMSearchResultsViewModelDelegate?
    init(results: RMSearchResultsType?, next: String?) {
        self.results = results
        self.next = next
    }
    
    
    
    
    var MustShowScrollview: Bool {return next != nil}
    var isLoadingDate = false
    
//MARK: - Fetching locations
    func fetchNewLocations(complation: @escaping([RMLocationCellViewModel], [RMLocation]) -> Void) {
        guard !isLoadingDate else{
            return
        }
        isLoadingDate = true
        
        guard let url = RMRequest(url: next ?? "") else{
            fatalError("CaantGetURL")
        }
//        print(url.url?.absoluteString)

        RMServise.shared.Execute(url, expecting:  RMCLocationWindow.self, completition: { [weak self] res in
            switch res{
            case .success(let reses):
                
                self?.next = reses.info.next
                let additinalResults = reses.results.compactMap { return RMLocationCellViewModel(location: $0) }
                var results: [RMLocationCellViewModel] = []
                switch self?.results {
                case .locations(let models):
                    results = models + additinalResults
                    self?.results = .locations(results)
                case .episodes(_): break
                case .characters(_): break
                case .none: break
                }
                complation(results, reses.results)
            case .failure(let Error):
                print(String(describing: Error))
                self?.isLoadingDate=false
                break
                
                
            }
            
        })
        
    }
    
    //MARK: - Fetching Characters
    func fetchNewChracters(complation: @escaping([RMCharacterListtCellViewModel], [RMCharacter]) -> Void) {
        guard !isLoadingDate else{
            return
        }
        isLoadingDate = true
        
        guard let url = RMRequest(url: next ?? "") else{
            fatalError("CaantGetURL")
        }
//        print(url.url?.absoluteString)

        RMServise.shared.Execute(url, expecting:  RMCharacterWindow.self, completition: { [weak self] res in
            switch res{
            case .success(let reses):
                
                self?.next = reses.info.next
                let additinalResults = reses.results.compactMap { return RMCharacterListtCellViewModel(
                    name: $0.name,
                    status: $0.status,
                    img: URL(string: $0.image)) }
                var results: [RMCharacterListtCellViewModel] = []
                switch self?.results {
                case .locations(_): break
                case .episodes(_): break
                case .characters(let models):
                    results = models + additinalResults
                    self?.results = .characters(results)
                case .none: break
                }
                complation(results, reses.results)
            case .failure(let Error):
                print(String(describing: Error))
                self?.isLoadingDate=false
                break
                
                
            }
        })
        
    }
    
    //MARK: - FETCH NEW EPISODES
    func fetchNewEpisodes(complation: @escaping([RMEpisodeViewCellViewModel], [RMEpisode]) -> Void) {
        guard !isLoadingDate else{
            return
        }
        isLoadingDate = true
        
        guard let url = RMRequest(url: next ?? "") else{
            fatalError("CaantGetURL")
        }
//        print(url.url?.absoluteString)

        RMServise.shared.Execute(url, expecting:  RMEpisodeWindow.self, completition: { [weak self] res in
            switch res{
            case .success(let reses):
                
                self?.next = reses.info.next
                let additinalResults = reses.results.compactMap { return RMEpisodeViewCellViewModel(episodeUrl: URL(string: $0.url)) }
                var results: [RMEpisodeViewCellViewModel] = []
                switch self?.results {
                case .locations(_): break
                case .episodes(let models):
                    results = models + additinalResults
                    self?.results = .episodes(results)
                case .characters(let models):
                    break
                case .none: break
                }
                complation(results, reses.results)
            case .failure(let Error):
                print(String(describing: Error))
                self?.isLoadingDate=false
                break
                
                
            }
        })
        
    }
}


enum RMSearchResultsType {
    case characters ([RMCharacterListtCellViewModel])
    case episodes ([RMEpisodeViewCellViewModel])
    case locations ([RMLocationCellViewModel])
}
