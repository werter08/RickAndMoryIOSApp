import Foundation
import UIKit

class RMCharacterListViewViewModel: NSObject{
    
    //function which gives us a data about characters from API
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

//its for a grid in view
extension RMCharacterListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //functtion which detects how many object is in grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //function wchich takes an object to add to grid
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharackterListCellView.cellIdentifier,
            for: indexPath) as? RMCharackterListCellView else {
            return UICollectionViewCell()
        }
                
        let cellViewModel = RMCharacterListtCellViewModel(name: "begenc",
                                                         status: .alive,
                                                          img: URL(string: "https://rickandmortyapi.com/api/character/avatar/20.jpeg"))
        cell.Configure(with: cellViewModel)
        return cell
    }
    
    //function which takes a size of each object
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width-30)/2
        return CGSize(width: width, height: width*1.5)
    }
    
}
