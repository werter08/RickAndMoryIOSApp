//
//  RMCharacterEpisodeViewCell.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 30.03.2025.
//

import UIKit

class RMEpisodeListCellView: UICollectionViewCell {
    static let Identifier = "RMEpisodeViewCell"
    
    let episodeLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        return label
    }()
   
    let DateLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondarySystemBackground
        label.font = .systemFont(ofSize: 24, weight: .light)
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemBlue
        contentView.layer.cornerRadius = 10
        SetUpConstrains()
    }
    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        contentView.backgroundColor = .secondarySystemBackground
//    
//    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUpConstrains(){
        addSubs(nameLabel, episodeLabel, DateLabel)
        NSLayoutConstraint.activate([
            episodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            episodeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            episodeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            episodeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            nameLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            DateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            DateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            DateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            DateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    public func Configure(viewMOdel: RMEpisodeViewCellViewModel){
            viewMOdel.RegisterForDate { [weak self] data in
            self?.nameLabel.text = data.name
            self?.DateLabel.text = "Aired on "+data.air_date
            self?.episodeLabel.text = "Episode "+data.episode
        }
        
        viewMOdel.fetchEpisode()
    }
    
}
