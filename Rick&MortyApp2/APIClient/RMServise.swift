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
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                
                completition(.failure(error ?? APIServiceErrors.cantGetData))
                    return
            }
            
            
            do{
                let json = try JSONSerialization.jsonObject(with: data)
                //print(String(describing: json))
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
    
    public struct ListCharacterRequests{
        static let charachtersRequest = RMRequest.init(endPoint: .character)
    }
}

