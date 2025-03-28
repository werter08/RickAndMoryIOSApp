

import UIKit

class RMCharactersVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title="Characters"
        
        let char = RMRequest(endPoint: .character, pathComponent: ["1", "2"])
        print(char.url)
    }
    

    

}
