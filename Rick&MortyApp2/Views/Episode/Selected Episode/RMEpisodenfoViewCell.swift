//
//  RMCharacterInfoViewCell.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 30.03.2025.
//

import UIKit

class RMEpisodeInfoViewCell: UICollectionViewCell {
    static let Identifier = "RMEpisodeInfoViewCell"
    
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
        label.textColor = .black
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        return label
    }()
    let titleView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
        contentView.addSubs(titleView, valueLabel)
        titleView.addSubs(iconImage, titleLabel)
        
        NSLayoutConstraint.activate([
            
            titleView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.40),
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            iconImage.heightAnchor.constraint(equalToConstant: 25),
            iconImage.widthAnchor.constraint(equalToConstant: 25),
            
            titleLabel.leftAnchor.constraint(equalTo: titleView.leftAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor, constant: -40),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -5),
            
            iconImage.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 5),
            iconImage.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 10),
            iconImage.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -10),
            
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            valueLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor),
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
    public func Configure(viewMOdel: RMEpisodeInfoViewCellViewModel){
        titleLabel.text = viewMOdel.toShowTitle
        titleLabel.textColor = viewMOdel.toShowColor
        iconImage.tintColor = viewMOdel.toShowColor
        valueLabel.text = viewMOdel.toShowValue
    }
}
