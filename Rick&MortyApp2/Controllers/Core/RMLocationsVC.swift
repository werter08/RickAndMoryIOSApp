
import UIKit

class RMLocationsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title="Locations"
        setUpSearchButton()
    }
    

    private func setUpSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapButtonTapped))
    }
    @objc private func tapButtonTapped(){
        
    }

}
