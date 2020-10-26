//
//  UIButton+layer.swift
//  S2S Demo App
//
//  Created by Christian Müller on 12.10.20.
//

import UIKit

extension UIButton {
    func setUpLayer(button: UIButton, title: String) {
        button.setTitle(title, for: UIControl.State.normal)
        button.tintColor =  UIColor.white
        button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        button.layer.cornerRadius = 5.0

        button.layer.shadowRadius =  3.0
        button.layer.shadowColor =  UIColor.white.cgColor
        button.layer.shadowOpacity =  0.3
        
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        
        button.titleLabel?.font = UIFont(name: "Lato", size: 17)
    }

}
