//
//  RMAPICasheManager.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 02.04.2025.
//

import Foundation

class RMAPICasheManager{
    
    
    private var casheDate:[RMEndPoint: NSCache<NSString, NSData>] = [:]
    
    init(){}
    
    private func SetCeshes(){
        RMEndPoint.allCases.forEach { endpoint in
            casheDate[endpoint] = NSCache<NSString, NSData>()
        }
    }
    
    public func SetCashe(endPoint:RMEndPoint, url:URL?, data:Data){
        guard let url = url?.absoluteString as? NSString else{
            return
        }
        casheDate[endPoint]?.setObject(data as NSData, forKey: url as NSString)
    }
    
    public func GetFromCashe(endpoint:RMEndPoint, url:URL?) -> Data?{
        guard let url = url?.absoluteString, let targetCash = casheDate[endpoint] else{
            return nil
        }
        return targetCash.object(forKey: url as NSString) as? Data
    }
}
