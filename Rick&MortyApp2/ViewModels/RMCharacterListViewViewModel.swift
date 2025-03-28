import Foundation

struct RMCharacterListViewViewModel{
    
    
    func FetchCharacters(){
        RMServise.shared.Execute( RMServise.ListCharacterRequests.charachtersRequest ,expecting: RMCharacter.self) {res in
               switch res{
                   case .success:
                       break
       
                   case .failure(let Error):
                       print(String(describing: Error))
                       break
               }
           }
    }
    

}
