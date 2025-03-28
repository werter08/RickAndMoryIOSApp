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
