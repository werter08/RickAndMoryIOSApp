//
//  RMServise.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 28.03.2025.
//
import Foundation

/// servise to get data from API
final class RMServise{
    
    /// shared singleton
    static let shared = RMServise()
    
    private let casheManager = RMAPICasheManager()
    private init() {}
    
    private enum APIServiceErrors: Error {
        case cantGetURL
        case cantGetData
    }
    
    /// Send a call to Api
    /// - Parameters:
    ///   - request: call data
    ///   - completition: our get from API
    public func Execute<T:Codable>(
        _ request:RMRequest,
        expecting type:T.Type,
        completition: @escaping (Result<T,Error>) -> Void
    ){
        guard let urlRequest = self.request(from: request) else{
            completition(.failure(APIServiceErrors.cantGetURL))
            return
        }
        if let data = casheManager.GetFromCashe(endpoint: request.endPoint, url: request.url) {
            
            do{
                let result = try JSONDecoder().decode(type.self, from: data)
                completition(.success(result))
            }catch{
                completition(.failure(error))
            }
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                
                completition(.failure(error ?? APIServiceErrors.cantGetData))
                    return
            }
            
            
            do{
                let result = try JSONDecoder().decode(type.self, from: data)
                completition(.success(result))
                self.casheManager.SetCashe(endPoint: request.endPoint, url: request.url, data: data)
            }catch{
                completition(.failure(error))
            }
        }
        task.resume()
    }
    
    
    
    private func request (from rmRequest: RMRequest) -> URLRequest?{
        guard let url = rmRequest.url else{
            return nil
        }
        //print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = rmRequest.HTTPMethod
        return urlRequest
    }
    
    public struct ListRequests{
        static let charachtersRequest = RMRequest.init(endPoint: .character)
        static let episodesRequest = RMRequest.init(endPoint: .episode)
        static let locationsRequest = RMRequest.init(endPoint: .location)
    }
}

