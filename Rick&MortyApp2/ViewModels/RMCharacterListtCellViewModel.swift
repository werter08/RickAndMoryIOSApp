
import UIKit

class RMCharacterListtCellViewModel{
    public let name:String
    private let status:RMCharacterStatus
    public let imgURL: URL?
    
    init(name: String, status: RMCharacterStatus, img: URL?) {
        self.name = name
        self.status = status
        self.imgURL = img
    }
    
    //convert enum case to string
    public func StatusText() -> String{
        self.status.rawValue
    }
    
    
    //function to download an imange
    public func FetchImage(completion: @escaping (Result<Data,Error>) -> Void){
        guard let url=imgURL else{
            completion(.failure(URLError(.badURL)))
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest){data,_,error in
            guard let data, error==nil else{
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
        
        
        
    }
}
