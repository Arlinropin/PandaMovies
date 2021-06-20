//
//  DescriptionTableViewCell.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 20/06/21.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var box: UIView!
    @IBOutlet weak var boxS: UIView!
    @IBOutlet weak var boxTitle: UIView!
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var star: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
    func initWithData(movie: Movie){
        var backdropImage = movie.backdrop_image
        if movie.backdrop_image ==  #imageLiteral(resourceName: "PandaSearch") {
            backdropImage = movie.poster_image
        }
        let color = backdropImage.averageColor
        let inverseColor = color?.inverseColor() ?? UIColor.white
        var titleColor = UIColor.white
        var textColor = UIColor.white
        if (color?.isLight())! {
            textColor = .black
        }
        if (inverseColor.isLight())! {
            titleColor = .black
        }
        let average = round(movie.vote_average * 10) / 10.0

        
        box.backgroundColor = color
        boxS.backgroundColor = color
        boxTitle.backgroundColor = inverseColor
        poster.image = movie.poster_image
        backdrop.image = backdropImage
        titleLabel.text = movie.title
        titleLabel.textColor = titleColor
        descriptionLabel.text = movie.overview
        descriptionLabel.textColor = textColor
        star.tintColor = #colorLiteral(red: 0.9112964272, green: 0.7747166753, blue: 0.3718485832, alpha: 1)
        rating.text = "\(average)"
        rating.textColor = textColor
    }
}
