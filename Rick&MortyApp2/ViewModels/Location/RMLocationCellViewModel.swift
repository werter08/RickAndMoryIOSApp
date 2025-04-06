//
//  RMLOcationListViewModel.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//



final class RMLocationCellViewModel: Equatable {
    
    private let location:RMLocation
    
    init(location: RMLocation) {
        self.location = location
    }
    
    public var name: String {
        return location.name
    }
    public var type: String {
        return "Type: "+location.type
    }
    public var dimension: String {
        return location.dimension
    }
    
    public var model: RMLocation {
        return location
    }
    
    static func == (lhs: RMLocationCellViewModel, rhs: RMLocationCellViewModel) -> Bool {
        lhs.location.id == rhs.location.id
    }
}
