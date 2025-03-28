

import UIKit

class RMCharactersVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title="Characters"
        let charackterList = RMCharackterListView()
        view.addSubview(charackterList)
        
        NSLayoutConstraint.activate([
            charackterList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charackterList.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            charackterList.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            charackterList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
       
    }
    

    

}
