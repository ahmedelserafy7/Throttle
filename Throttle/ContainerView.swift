//
//  ContainerView.swift
//  Throttle
//
//  Created by Elser_10 on 2/8/21.
//  Copyright © 2021 Elser_10. All rights reserved.
//

import UIKit

class ContainerView: UIView {
    
    let notificationLabel:  UILabel = {
        let label = UILabel()
        label.text = "Please select at least one seat."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.layer.cornerRadius = 16
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(red: 1, green: 58/255, blue: 43/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var exitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "exit")
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExit)))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    @objc func handleExit() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.transform = .identity
        }, completion: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        addSubview(notificationLabel)
        NSLayoutConstraint.activate([
            notificationLabel.topAnchor.constraint(equalTo: topAnchor),
            notificationLabel.leftAnchor.constraint(equalTo: leftAnchor),
            notificationLabel.rightAnchor.constraint(equalTo: rightAnchor),
            notificationLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(exitImageView)
        NSLayoutConstraint.activate([
            exitImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            exitImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            exitImageView.widthAnchor.constraint(equalToConstant: 30),
            exitImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
