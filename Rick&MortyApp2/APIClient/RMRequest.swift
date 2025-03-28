//
//  RMRequest.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 28.03.2025.
//

import Foundation


//object represents a single API call
final class RMRequest{
    //base
    //endPoint
    //optionalPath
    //Queryparametr
    private struct Constants {static let baseUrl = "https://rickandmortyapi.com/api"}
    private let endPoint: RMEndPoint
    private var pathComponent: Set<String>
    private let queryParameter: [URLQueryItem]
    
    private var urlString:String {
        var str:String = Constants.baseUrl
        str += "/"
        str+=endPoint.rawValue
        
        if !pathComponent.isEmpty{
            if(pathComponent.count>1){
                str+="/\(pathComponent.first!)"
                pathComponent.remove(pathComponent.first!)
                pathComponent.forEach({
                    str+=",\($0)"
                })
            }else{
                str+="/\(pathComponent.first!)"
            }
            
        }
        
        if !queryParameter.isEmpty{
            str+="?"
            let argumentStr=queryParameter.compactMap({
                guard let v = $0.value else{return nil}
                return "\($0.name)=\(v)"
            }).joined(separator: "&")
            
            str+=argumentStr
        }
        
        return str
    }
   
    public var url:URL? {
        return URL(string: urlString)
    }
    
    public let HTTPMethod = "GET"
    
    
    public init(endPoint:RMEndPoint, pathComponent: Set<String> = [], queryParametr:[URLQueryItem] = []){
        self.pathComponent = pathComponent
        self.endPoint=endPoint
        self.queryParameter = queryParametr
    }
}
