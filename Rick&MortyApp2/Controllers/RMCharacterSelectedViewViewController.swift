//
//  RMCharacterSelectedViewViewController.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 29.03.2025.
//

import UIKit

class RMCharacterSelectedViewViewController: UIViewController {

    
     init(viewModel:RMCharacterSelectedViewViewModel){
         super.init(nibName: nil, bundle: nil)
         title = viewModel.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    


}
