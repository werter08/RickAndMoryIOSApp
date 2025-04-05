
import UIKit

class RMLocationsVC: UIViewController, RMLocationListViewModelDelegate, RMLocationListViewDelegate{
    
    func didTapped(_ listView: RMLocationListView, model: RMLocation) {
        let vc = RMLocationSelectedViewController(model: model)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    

    

    private let contentView = RMLocationListView()
    
    private let viewModel = RMLocationListViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title="Locations"
        setUpSearchButton()
        setUPConstraionts()
        viewModel.delegate = self
        contentView.delegate = self
        viewModel.fetchLocations()
    }
    

    private func setUpSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapButtonTapped))
    }
    @objc private func tapButtonTapped(){
        
    }
    private func setUPConstraionts(){
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func didFetch() {
        contentView.configure(viewModel: self.viewModel)
    }
}
