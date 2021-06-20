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
    
    static func showSpinner(){
        let currentController = Navigation.getCurrentController()
        viewBack.frame = UIScreen.main.bounds
        viewBack.backgroundColor = UIColor.white.withAlphaComponent(0.85)

        spinner = .init(name: "panda-eats-popcorn")
        spinner!.frame = UIScreen.main.bounds
        spinner?.loopMode = .loop
        viewBack.addSubview(spinner!)
        UIView.animate(withDuration: 0.3, animations: {viewBack.alpha = 1.0}, completion: {(value: Bool) in currentController!.view.addSubview(viewBack) })
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
