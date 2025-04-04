import Foundation
import UIKit

protocol RMEpisodeListtCellViewModelDelegate : AnyObject {
    func DidLoad()
    func NewepisodesDidLoad(with indexPath:[IndexPath])
    func episodeTapped(episode:RMEpisode)
}

class RMEpisodeListViewViewModel: NSObject {
    
    public var isLoadingepisodeacters:Bool = false
    
    public weak var delegate:RMEpisodeListtCellViewModelDelegate?
    
    var episodeData:[RMEpisode] = [] {
        didSet {
            for episode in episodeData {
                let module = RMEpisodeViewCellViewModel(episodeUrl: URL(string: episode.url))
                
                if !episodeCellModule.contains(module){
                    episodeCellModule.append(module)
                }
            }
        }
    }
    
    
    
    var episodeCellModule:[RMEpisodeViewCellViewModel] = []
    
    var apiInffo:RMInfo?
    
    //function which gives us a data about episodeacters from API
    func FetchEpisode() {
        RMServise.shared.Execute(
            RMServise.ListRequests.episodesRequest ,
            expecting: RMEpisodeWindow.self) {[weak self] res in
               switch res{
                   case .success(let reses):
                        let results = reses.results
                        let info=reses.info
                       
                        self?.episodeData = results
                        self?.apiInffo = info
                        self?.delegate?.DidLoad()
                        break
                    case .failure(let Error):
                       print(String(describing: Error))
                       break
               }
           }
        isLoadingepisodeacters = false
    }
    
    // MARK: Fetching from footer
    func FetchNewEpisode() {
        guard !isLoadingepisodeacters else{
            return
        }
        isLoadingepisodeacters = true
        
        guard let url = RMRequest(url: apiInffo?.next ?? "") else{
            fatalError("CaantGetURL")
        }
        
        print("IsFetching")
        RMServise.shared.Execute(url,
                                 expecting: RMEpisodeWindow.self) {[weak self] res in
            
            switch res{
            case .success(let reses):
                let results = reses.results
                let info=reses.info
                
                
                
                self?.apiInffo = info
                
                let count = self?.episodeData.count
                let new = results.count
                let total = count!+new
                let indexStart = total-new
 
                
                let indexPathsToAdd:[IndexPath] = Array(indexStart..<(indexStart+new)).compactMap({
                    return IndexPath(row:$0, section: 0)
                })
//              print("indexPathsToAdd: \(indexPathsToAdd)")
                self?.episodeData.append(contentsOf: results)
//              print("post-count: \(String(describing: self?.episodeCellModule.count))")
                DispatchQueue.main.async {
                    
                    self?.delegate?.NewepisodesDidLoad(with: indexPathsToAdd)
                    self?.isLoadingepisodeacters=false
                    
                }
                
                break
                
                
            case .failure(let Error):
                print(String(describing: Error))
                self?.isLoadingepisodeacters=false
                break
            }
            
        }
    }
    
    public var MustShowScrollview: Bool {
        return (apiInffo?.next) != nil
    }
}



//its for a grid in view (cells)
extension RMEpisodeListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //functtion which detects how many object is in grid
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodeCellModule.count
    }
    
    //function wchich takes an object to add to grid
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMEpisodeListCellView.Identifier,
            for: indexPath) as? RMEpisodeListCellView else {
            return UICollectionViewCell()
        }

        cell.Configure(viewMOdel: episodeCellModule[indexPath.row])
        return cell
    }
    
    //function which takes a size of each object
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width-30)
        return CGSize(width: width, height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let episode = episodeData[indexPath.row]
        delegate?.episodeTapped(episode: episode)
    }
}

//footer loading bar
extension RMEpisodeListViewViewModel {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,  let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: RMEpisodeListViewCollectionReusableView.identifier,
            for: indexPath) as? RMEpisodeListViewCollectionReusableView else{
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





extension RMEpisodeListViewViewModel: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard MustShowScrollview,
                !isLoadingepisodeacters
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
                    self?.FetchNewEpisode()
                }
                t.invalidate()
        }
        
   
        
    }
}
