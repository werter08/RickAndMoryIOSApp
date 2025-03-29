import Foundation
import UIKit

protocol RMCharacterListtCellViewModelDelegate : AnyObject{
    func DidLoad()
    func NewCharsDidLoad(with indexPath:[IndexPath])
    func charTapped(character:RMCharacter)
}
class RMCharacterListViewViewModel: NSObject{
    
    public var isLoadingCharacters:Bool = false
    
    public weak var delegate:RMCharacterListtCellViewModelDelegate?
    var CharData:[RMCharacter] = [] {
        didSet{
            for char in CharData{
                let module = RMCharacterListtCellViewModel(
                    name: char.name,
                    status: char.status,
                    img: URL(string: char.image))
                
                if !charCellModule.contains(module){
                    charCellModule.append(module)
                }
            }
        }
    }
    
    
    
    var charCellModule:[RMCharacterListtCellViewModel] = []
    
    var apiInffo:RMInfo?
    
    //function which gives us a data about characters from API
    func FetchCharacters(){
        RMServise.shared.Execute(
            RMServise.ListCharacterRequests.charachtersRequest ,
            expecting: RMCharacterWindow.self) {[weak self] res in
               switch res{
                   case .success(let reses):
                        let results = reses.results
                        let info=reses.info
                       
                        self?.CharData = results
                        self?.apiInffo = info
                        self?.delegate?.DidLoad()
                        break
                    case .failure(let Error):
                       print(String(describing: Error))
                       break
               }
           }
        isLoadingCharacters = false
    }
    
    
    
    //MARK: Fetching from footer
    
    func FetchNewCharacters(){
                guard !isLoadingCharacters else{
                    return
                }
        isLoadingCharacters = true
      
        guard let url = RMRequest(url: apiInffo?.next ?? "") else{
            fatalError("CaantGetURL")
        }
        
        print("IsFetching")
        RMServise.shared.Execute(url,
                                 expecting: RMCharacterWindow.self) {[weak self] res in
            
            switch res{
                case .success(let reses):
                let results = reses.results
                let info=reses.info
                    
                
             
                self?.apiInffo = info
                
                let count = self?.CharData.count
                let new = results.count
                let total = count!+new
                let indexStart = total-new
                print("pre-count: \(String(describing: self?.charCellModule.count))")
                print("new: \(new)")
                print("indexStart: \(indexStart)")
                print(results.first?.name)
                
                let indexPathsToAdd:[IndexPath] = Array(indexStart..<(indexStart+new)).compactMap({
                    return IndexPath(row:$0, section: 0)
                })
                print("indexPathsToAdd: \(indexPathsToAdd)")
                self?.CharData.append(contentsOf: results)
                print("post-count: \(String(describing: self?.charCellModule.count))")
                DispatchQueue.main.async {
                    
                    self?.delegate?.NewCharsDidLoad(with: indexPathsToAdd)
                    self?.isLoadingCharacters=false
                   
                }
               
                break
                
                
                 case .failure(let Error):
                    print(String(describing: Error))
                    self?.isLoadingCharacters=false
                    break
            }
            
        }
    }
    public var MustShowScrollview:Bool {
        
        return (apiInffo?.next) != nil
    }
}



//its for a grid in view (cells)
extension RMCharacterListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //functtion which detects how many object is in grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charCellModule.count
    }
    
    //function wchich takes an object to add to grid
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharackterListCellView.cellIdentifier,
            for: indexPath) as? RMCharackterListCellView else {
            return UICollectionViewCell()
        }
                
        cell.Configure(with: charCellModule[indexPath.row])
        return cell
    }
    
    //function which takes a size of each object
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width-30)/2
        return CGSize(width: width, height: width*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let char = CharData[indexPath.row]
        delegate?.charTapped(character: char)
    }
    
  
    

   
}

//footer loading bar
extension RMCharacterListViewViewModel{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,  let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: RMCharacterListViewCollectionReusableView.identifier,
            for: indexPath) as? RMCharacterListViewCollectionReusableView else{
            return  UICollectionReusableView()

        }
        footer.StartSpin()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard MustShowScrollview, apiInffo?.next != nil else{
            return .zero
        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}





extension RMCharacterListViewViewModel: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard MustShowScrollview,
                !isLoadingCharacters
        else{
            return
        }
        print("Buttom")
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {
            [weak self] t in
                let offset = scrollView.contentOffset.y
                let frameSize = scrollView.frame.size.height
                let totalSize = scrollView.contentSize.height
                
               
            if offset >= (totalSize - frameSize - 120){
                    //print("Bottom")
                    self?.FetchNewCharacters()
                }
                t.invalidate()
        }
        
   
        
    }
}
