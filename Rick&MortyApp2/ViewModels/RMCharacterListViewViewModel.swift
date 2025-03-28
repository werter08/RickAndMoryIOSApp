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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
    //function which takes a size of each object
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width-30)/2
        return CGSize(width: width, height: width*1.5)
    }
    
}
