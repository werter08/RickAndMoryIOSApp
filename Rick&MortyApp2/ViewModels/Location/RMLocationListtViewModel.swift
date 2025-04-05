//
//  RMLOcationListViewModel.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

protocol RMLocationListViewModelDelegate: AnyObject {
    func didFetch()
}


final class RMLocationListViewModel {
    
    weak var delegate: (RMLocationListViewModelDelegate)?
    
    private var locations: [RMLocation] = []{
        didSet {
            for location in locations {
                let module = RMLocationCellViewModel(location: location)
                if !cellModels.contains(module) {
                    cellModels.append(module)
                }
            }
        }
    }
    private var apiInfo: RMInfo?
    public var cellModels: [RMLocationCellViewModel] = []
    init(){}
    
    public func getLocation(index: Int) -> RMLocation? {
        guard index < locations.count else {
            return nil
        }
        return locations[index]
    }
    
    
    public func fetchLocations(){
        RMServise.shared.Execute(RMServise.ListRequests.locationsRequest, expecting: RMCLocationWindow.self) {[weak self] Result in
            switch Result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
      
                self?.delegate?.didFetch()
                
        
            case .failure(let f):
                print(String(describing: f))
            }
        }
    }
    
    private var hasMore = {
        return false
    }
}
