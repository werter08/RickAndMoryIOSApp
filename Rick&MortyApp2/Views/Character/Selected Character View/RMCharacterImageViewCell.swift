//
//  RMCharacterImageViewCell.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 30.03.2025.
//

import UIKit

class RMCharacterImageViewCell: UICollectionViewCell {
    static let Identifier = "RMCharacterImageViewCell"
    
    let image:UIImageView = {
        let image=UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        SetUpConstrains()
        contentView.layer.cornerRadius = 100
        image.layer.cornerRadius = 100
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUpConstrains(){
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
    public func Configure(viewMOdel: RMCharacterImageViewCellViewModel){
        viewMOdel.FetchImage { res in
            switch res {
            case .success(let success):
                self.image.image = UIImage(data: success)
            case .failure:
                break
            }
        }
        
    }
}
