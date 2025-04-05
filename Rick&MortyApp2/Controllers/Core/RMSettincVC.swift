import SafariServices
import UIKit
import SwiftUI
import StoreKit
class RMSettingsVC: UIViewController {

    var contentVC: UIHostingController<RMSettingsView>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title="Settings"
        setUpSearchButton()
        setUPSwiftUIView()
    }
    

    private func setUpSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapButtonTapped))
    }
    @objc private func tapButtonTapped(){
        
    }

    private func setUPSwiftUIView(){
        let contentViewController = UIHostingController(
            rootView: RMSettingsView(viewModel:RMSettingsViewViewModel(viewCells: RMSettingsOptions.allCases.compactMap({
                return RMSettingsCellViewModul(type: $0){option in
                    guard Thread.current.isMainThread else {
                        return
                    }
                    if let url = option.link{
                        let vc = SFSafariViewController(url: url)
                        self.present(vc, animated: true)
                    }else if option == .rateApp{
                        if let window = self.view.window?.windowScene{
                            AppStore.requestReview(in: window)
                        }
                    }
                }
            }))))
        
        
        addChild(contentViewController)
        contentViewController.didMove(toParent: self)
        
        view.addSubview(contentViewController.view)
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentViewController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            contentViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentViewController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        self.contentVC = contentViewController
    }
   
}
