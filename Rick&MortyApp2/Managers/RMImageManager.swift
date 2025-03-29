//
//  RMImageManager.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 29.03.2025.
//

import Foundation
class RMImageManager{
    
    static let shared = RMImageManager()
    private var cashe = NSCache<NSString,NSData>()
    init(){}
    
    public func DownloadImage(url:URL, completion: @escaping (Result<Data,Error>) -> Void){
        let key = url.absoluteString as NSString
        

        if let data = self.cashe.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest){data,_,error in
            guard let data, error==nil else{
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }
            self.cashe.setObject(data as NSData, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
    
}
