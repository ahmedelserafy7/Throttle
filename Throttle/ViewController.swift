//
//  ViewController.swift
//  Throttle
//
//  Created by Elser_10 on 1/23/21.
//  Copyright © 2021 Elser_10. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var checkOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Checkout with", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 124/255, blue: 148/255, alpha: 1), for: .normal)
        button.setImage(#imageLiteral(resourceName: "fawry").withRenderingMode(.alwaysOriginal), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/250, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.semanticContentAttribute = .forceRightToLeft
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCheckOut), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var throttler = Throttle(minimumDelay: 2)
    @objc func handleCheckOut() {
        throttler.throttle({ [weak self] in
            self?.setupNotificationMessage()
        })
    }
    
    func setupNotificationMessage() {
        
        let notificationLabelHeight: CGFloat = 70
        let notchGap: CGFloat = 30
        let space: CGFloat = 6
        
        let containerView = ContainerView()
        containerView.frame = CGRect(x: 30, y: -notificationLabelHeight, width: self.view.frame.width - 60, height: notificationLabelHeight)
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        
        view.addSubview(containerView)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            
            containerView.transform = CGAffineTransform(translationX: 0, y: notificationLabelHeight + notchGap + space)
        }) { _ in
            
            UIView.animate(withDuration: 0.75, delay: 1.25, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                containerView.transform = .identity
                
            }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(checkOutButton)
        
        checkOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        checkOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        checkOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        checkOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
