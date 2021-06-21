//
//  SearchTableViewCell.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var cleanButton: UIButton!
    
    var callbackSearch: (()->Void)?
    var callbackClean: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textfield.layer.cornerRadius = 10
        cleanButton.isHidden = true
    }
    
    @IBAction func serach(_ sender: UIButton) {
        cleanButton.isHidden = false
        callbackSearch!()
    }
    
    @IBAction func cleanSearch(_ sender: UIButton) {
        textfield.text = ""
        cleanButton.isHidden = true
        callbackClean!()
    }
}
