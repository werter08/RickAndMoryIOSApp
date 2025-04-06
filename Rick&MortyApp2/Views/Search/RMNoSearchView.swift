//
//  RMNoSearchView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import UIKit

class RMNoSearchView: UIView {

    private var viewModel: RMNoSearchViewModel?
    
    //MARK: - UI
    private var stack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center

        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .blue
        return image
    }()
    
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        isHidden = true
        stack.constraintsToView(stack: stack, view: self)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configure
    func configure(viewModel: RMNoSearchViewModel){
        label.text = viewModel.label
        image.image = viewModel.icon
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 70),
            image.heightAnchor.constraint(equalToConstant: 70)
            
            
        ])
        
        stack.addArrangedSubViews(image, label)

    }
}
