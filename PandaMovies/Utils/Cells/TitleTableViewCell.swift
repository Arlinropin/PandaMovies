//
//  TitleTableViewCell.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 20/06/21.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    var callback: (()->Void)?
    
    @IBAction func update(_ sender: UIButton) {
        callback!()
    }
}
