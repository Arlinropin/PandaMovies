//
//  Modal.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//

import UIKit

class Modal: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    private static var view: Modal?
    private static var viewBack = UIView()
    
    var texts: ModalText?
    var callback: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = texts?.title
        messageLabel.text = texts?.message
    }

    @IBAction func close(_ sender: UIButton) {
        callback!()
    }
}
