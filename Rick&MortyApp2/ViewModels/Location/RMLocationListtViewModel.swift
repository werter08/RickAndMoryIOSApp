//
//  RMLOcationListViewModel.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import Foundation

protocol RMLocationListViewModelDelegate: AnyObject {
    func didFetch()
    func NewLocationsDidLoad(with: [IndexPath])
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
    
    var isLoadingCharacters = false
    
    
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
    
    func fetchNewLocations() {
        guard !isLoadingCharacters else{
            return
        }
        isLoadingCharacters = true
        
        guard let url = RMRequest(url: apiInfo?.next ?? "") else{
            fatalError("CaantGetURL")
        }
//        print(url.url?.absoluteString)

        RMServise.shared.Execute(url, expecting:  RMCLocationWindow.self, completition: { [weak self] res in
            switch res{
            case .success(let reses):
                let results = reses.results
                let info=reses.info
                
     
                
                self?.apiInfo = info
                
                let count = self?.locations.count
                let new = results.count
                let total = count!+new
                let indexStart = total-new
                
                let indexPathsToAdd: [IndexPath] = Array(indexStart..<(indexStart+new)).compactMap({
                    return IndexPath(row:$0, section: 0)
                })
                
                self?.locations.append(contentsOf: results)
                DispatchQueue.main.async {
                    self?.delegate?.NewLocationsDidLoad(with: indexPathsToAdd)
//                    self?.isLoadingCharacters=false

                }
                
                break
                
                
            case .failure(let Error):
                print(String(describing: Error))
                self?.isLoadingCharacters=false
                break
            }
        })
    }
            
            
        
    
    
    public var MustShowScrollview: Bool {
        return (apiInfo?.next) != nil
    }
    
    private var hasMore = {
        return false
    }
}
