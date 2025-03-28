

import UIKit

class RMCharactersVC: UIViewController {
    let charackterList = RMCharackterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title="Characters"
        SetUpConstraint()
    }
    

    
    private func SetUpConstraint(){
        
        view.addSubview(charackterList)
        NSLayoutConstraint.activate([
            charackterList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            charackterList.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            charackterList.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            charackterList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}
