//
//  PosterCollectionViewCell.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var box: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func initWithData(image: UIImage, label: String){
        self.image.image = image
        self.label.text = label
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        box.layer.cornerRadius = 5
    }

}
