//
//  spinner.swift
//  SuperWOW
//
//  Created by Arlin Ropero on 8/14/20.
//  Copyright © 2020 Proximate. All rights reserved.
//

import Foundation
import Lottie

@available(iOS 13.0, *)
class Spinner: UIViewController {
    
    private static var spinner: AnimationView?
    private static var viewBack = UIView()
    private static let messageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static func showSpinner(message: String){
        let currentController = Navigation.getCurrentController()
        viewBack.frame = UIScreen.main.bounds
        viewBack.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        viewBack.addSubview(messageLabel)
        messageLabel.attributedText = message.B(size: 25, color: #colorLiteral(red: 0.2823529412, green: 0.5882352941, blue: 0.1450980392, alpha: 1))
        messageLabel.centerXAnchor.constraint(equalTo: viewBack.centerXAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: viewBack.leadingAnchor, constant: 30).isActive = true
        messageLabel.topAnchor.constraint(equalTo: viewBack.centerYAnchor, constant: 110).isActive = true
        
        spinner = .init(name: "panda-eats-popcorn")
        spinner!.frame = UIScreen.main.bounds
        spinner?.loopMode = .loop
        
        viewBack.addSubview(spinner!)
        
        UIView.animate(withDuration: 0.3, animations: {viewBack.alpha = 1.0}, completion: {(value: Bool) in currentController!.view.addSubview(viewBack)
        })
        spinner?.play()
    }
    
    static func closeSpinner(completion: @escaping ()->Void = {}){
        UIView.animate(withDuration: 0.1, animations: {viewBack.alpha = 0.0}, completion: {(value: Bool) in
            spinner?.removeFromSuperview()
            viewBack.removeFromSuperview()
            spinner?.removeFromSuperview()
        })
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {completion()}
    }
}
