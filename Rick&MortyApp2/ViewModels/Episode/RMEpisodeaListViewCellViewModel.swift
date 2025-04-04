//
//  RMCharacterEpisodeViewCell.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 30.03.2025.
//

import Foundation

protocol RMEpisodeInChar{
     var name:String {get}
     var air_date:String {get}
     var episode:String {get}
}




final class RMEpisodeViewCellViewModel {
    
    public let episodeUrl: URL?
    
    private var isFetching = false
    
    init(episodeUrl:URL?){
        self.episodeUrl = episodeUrl
    }
    private var dataBlock: ((RMEpisodeInChar) -> Void)?
    
    public func RegisterForDate(_ block: @escaping (RMEpisodeInChar) -> Void){
        self.dataBlock = block
    }
  
    private var model: RMEpisode? {
        didSet{
            guard let episode = model else{
                return
            }
            dataBlock?(episode)
        }
    }
    
    public func fetchEpisode(){
        guard !isFetching,
              let url = episodeUrl,
        let request = RMRequest(url: url.absoluteString) else {
            
            guard let model else{
                return
            }
            dataBlock?(model)
            return
        }
        
        isFetching = true
        RMServise.shared.Execute(request, expecting: RMEpisode.self) { [weak self] Res in
            switch Res {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.model = success
                    
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
        
    }
    
    
}

extension RMEpisodeViewCellViewModel:Equatable{
    static func ==(lhs: RMEpisodeViewCellViewModel, rhs: RMEpisodeViewCellViewModel) -> Bool {
        return lhs.episodeUrl == rhs.episodeUrl
    }
}
