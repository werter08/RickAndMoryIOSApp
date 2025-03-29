

import UIKit

class RMCharactersVC: UIViewController,RMCharackterListViewDelegate {
    let charackterList = RMCharackterListView()

    func CharTapped(_ charListView: RMCharackterListView, character: RMCharacter) {
        let vm=RMCharacterSelectedViewViewModel(char: character)
        let vc=RMCharacterSelectedViewViewController(viewModel: vm)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Characters"
        SetUpConstraint()
        charackterList.delegate = self
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
