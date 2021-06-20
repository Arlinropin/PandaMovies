//
//  Navigation.swift
//  CBook
//
//  Created by Arlin Ropero on 19/06/21.
//

import UIKit

class Navigation {
    
    static var spinner: Spinner?
    static var viewBack = UIView()
    static var view: Modal?
    
    static func getCurrentController() -> UIViewController? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.globalNavigationController?.viewControllers.last
    }
    
    static func showModalView(modalText: ModalText){
        let vc = getCurrentController()
        viewBack.frame = UIScreen.main.bounds
        viewBack.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        view = Modal()
        view!.texts = modalText
        view!.view.frame = UIScreen.main.bounds
        view!.callback = { closeModalView() }
        viewBack.addSubview(view!.view)
        UIView.animate(withDuration: 0.3, animations: {viewBack.alpha = 1.0}, completion: {(value: Bool) in vc!.view.addSubview(viewBack) })
    }
    
    static func closeModalView(){
        UIView.animate(withDuration: 0.1, animations: {viewBack.alpha = 0.0}, completion: {(value: Bool) in
            viewBack.removeFromSuperview()
        })
    }
    
    static func showSpinner() {
        Spinner.showSpinner()
    }
    
    static func closeSpinner(_ completion: @escaping (() -> Void) = {}) {
        Spinner.closeSpinner(completion: completion)
    }
}
