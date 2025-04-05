//
//  RMCharacterInfoViewCell.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 30.03.2025.
//

import UIKit

class RMLocationInfoViewCell: UICollectionViewCell {
    static let Identifier = "RMLocationInfoViewCell"
    
    let iconImage:UIImageView = {
        let image=UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.tintColor = .label
        return image;
    }()
    
    let valueLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4

        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true

        label.minimumScaleFactor = 0.4
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        return label
    }()
    let titleView:UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 10
        view.axis = .horizontal

        view.layer.cornerRadius = 8
        return view
    }()
    let titleViewWrapper:UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 0
        view.axis = .vertical
        view.alignment = .center
        view.backgroundColor = .blue
        view.layer.cornerRadius = 8
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemCyan
        contentView.layer.cornerRadius = 10

        
        SetUpConstrains()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
     //   super.traitCollectionDidChange(previousTraitCollection)
        contentView.backgroundColor = .systemCyan
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUpConstrains(){
        contentView.addSubs(titleViewWrapper, valueLabel)
        titleView.addSubs(iconImage, titleLabel)
        
        NSLayoutConstraint.activate([
            
            titleViewWrapper.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleViewWrapper.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleViewWrapper.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.40),
            titleViewWrapper.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            iconImage.widthAnchor.constraint(equalToConstant: 24),
            

            
//            iconImage.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 5),
//        //    iconImage.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 10),
//            iconImage.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -10),
            
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            valueLabel.topAnchor.constraint(equalTo: titleViewWrapper.bottomAnchor),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        titleLabel.textColor = nil
        iconImage.image = nil
        iconImage.tintColor = nil
        valueLabel.text = nil
    }
    public func Configure(viewMOdel: RMLocationInfoViewCellViewModel){
        titleLabel.text = viewMOdel.toShowTitle
        titleLabel.textColor = viewMOdel.toShowColor
        iconImage.tintColor = viewMOdel.toShowColor
        valueLabel.text = viewMOdel.toShowValue
        iconImage.image = viewMOdel.toShowIcon
        
        titleViewWrapper.addArrangedSubview(titleView)
        titleView.addArrangedSubview(titleLabel)
        titleView.addArrangedSubview(iconImage)
    }
}
