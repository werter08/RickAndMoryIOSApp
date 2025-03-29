//
//  RMCharackterListCollectionViewCellView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 29.03.2025.
//

import UIKit

class RMCharackterListCellView: UICollectionViewCell {

    
    
    public static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    
    let image:UIImageView = {
        let image=UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image;
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    let statusLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 19, weight: .light)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        SetUpViews()
        SetUpLayer()
        
    }
    required init?(coder: NSCoder) {
        fatalError("Unspeckted")
    }
    
    func SetUpLayer(){
        contentView.layer.cornerRadius=10
        contentView.layer.shadowColor=UIColor.label.cgColor
        contentView.layer.shadowOpacity=0.3
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius=5
    }
    
    func SetUpViews(){
        contentView.addSubs(image,nameLabel,statusLabel)
        NSLayoutConstraint.activate([
            
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
             statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            
            
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor)


        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        SetUpLayer()
    }
    
    public func Configure(with module: RMCharacterListtCellViewModel){
        nameLabel.text = module.name
        statusLabel.text = module.StatusText()
        module.FetchImage{res in
            switch res {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.image.image = image
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
