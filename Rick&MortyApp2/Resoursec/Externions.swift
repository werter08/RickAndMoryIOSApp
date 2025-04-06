//
//  Externions.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 28.03.2025.
//
import UIKit
extension UIView{
    func addSubs(_ view:UIView...){
        view.forEach({
            addSubview($0)
        })
    }
}

extension UIStackView{
    func addArrangedSubViews(_ view:UIView...){
        view.forEach({
            addArrangedSubview($0)
        })
    }
    func constraintsToView(stack: UIStackView, view: UIView){
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension UILabel {
    func addTrailing(image: UIImage) {
        let attachment = NSTextAttachment()
        attachment.image = image

        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: self.text!, attributes: [:])

        string.append(attachmentString)
        self.attributedText = string
    }
}
