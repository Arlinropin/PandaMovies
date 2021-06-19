//
//  Navigation.swift
//  CBook
//
//  Created by Arlin Ropero on 19/06/21.
//

import UIKit

class Navigation {
    
    static var spinner: Spinner?
    
    static func getCurrentController() -> UIViewController? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.globalNavigationController?.viewControllers.last
    }
    
    static func showSpinner() {
        Spinner.showSpinner()
    }
    
    static func closeSpinner(_ completion: @escaping (() -> Void) = {}) {
        Spinner.closeSpinner(completion: completion)
    }
}
