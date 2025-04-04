//
//  RMCharacterImageViewCell.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 30.03.2025.
//

import Foundation

final class RMCharacterImageViewCellViewModel {
    
    public let imageUrl: URL?
    
    init(imageUrl:URL?){
        self.imageUrl = imageUrl
    }
    
    func FetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        guard let imageUrl  else{
            completion(.failure(URLError(.badURL)))
            return
        }
        
        RMImageManager.shared.DownloadImage(url: imageUrl, completion: completion)
    }
}
