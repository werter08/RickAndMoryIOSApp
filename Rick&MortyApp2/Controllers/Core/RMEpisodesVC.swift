

import UIKit

class RMEpisodesVC: UIViewController,RMEpisodeListViewDelegate {
    func episodeTapped(_ charListView: RMEpisodeListView, episode: RMEpisode) {
        print("MOve")
        let vc=RMEpisodesSelectedViewController(url: URL(string: episode.url))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    

    let episodeList = RMEpisodeListView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Episode"
        episodeList.delegate = self
        SetUpConstraint()
        setUpSearchButton()
    }
    

    private func setUpSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapButtonTapped))
    }
    @objc private func tapButtonTapped(){
        let vc=RMSearchViewController(config: .init(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }


    
    private func SetUpConstraint(){
        
        view.addSubview(episodeList)
        NSLayoutConstraint.activate([
            episodeList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeList.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            episodeList.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            episodeList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }

    

}
