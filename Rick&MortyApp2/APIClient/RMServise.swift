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
    
    
    /// Send a call to Api
    /// - Parameters:
    ///   - request: call data
    ///   - completition: our get from API
    public func Execute(_ request:RMRequest, completition: @escaping () -> Void){
        
    }
}
