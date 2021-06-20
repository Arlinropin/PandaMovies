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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textfield.layer.cornerRadius = 10
        button.layer.cornerRadius = 10
    }
}
