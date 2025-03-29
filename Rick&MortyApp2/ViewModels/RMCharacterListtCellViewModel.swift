
import UIKit



class RMCharacterListtCellViewModel: Hashable{
    public let name:String
    private let status:RMCharacterStatus
    public let imgURL: URL?
    
    init(name: String, status: RMCharacterStatus, img: URL?) {
        self.name = name
        self.status = status
        self.imgURL = img
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(status)
        hasher.combine(imgURL)
    }
    
    //convert enum case to string
    public func StatusText() -> String{
        "Status: \(self.status.rawValue)"
    }
    
    
    //function to download an imange
    public func FetchImage(completion: @escaping (Result<Data,Error>) -> Void){
        guard let url=imgURL else{
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageManager.shared.DownloadImage(url: url, completion: completion)
        
        
        
    }
}
extension RMCharacterListtCellViewModel:Equatable{
    static func ==(lhs: RMCharacterListtCellViewModel, rhs: RMCharacterListtCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
