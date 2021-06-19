//
//  BaseController.swift
//  CBook
//
//  Created by Arlin Ropero on 31/05/21.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @objc func deviceOrientationDidChangeNotification(_ notification: Any) {
        self.view.setNeedsLayout()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func setUI() { }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func onClickBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func creatView(newView: UIViewController){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if(Navigation.getCurrentController()!.classForCoder != newView.classForCoder) {
            appDelegate.globalNavigationController!.pushViewController(newView, animated: true)
        }
    }
    
    func redirectToSettings(){
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
         }
    }
}
