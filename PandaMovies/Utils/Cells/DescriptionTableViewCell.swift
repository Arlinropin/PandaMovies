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
        
        let titleColor: UIColor = (movie.ineverse_color_average_backdrop.isLight())! ? .black:.white
        let textColor: UIColor = (movie.color_average_backdrop.isLight())! ? .black:.white

        box.backgroundColor = movie.color_average_backdrop
        boxS.backgroundColor = movie.color_average_backdrop
        boxTitle.backgroundColor = movie.ineverse_color_average_backdrop
        poster.image = movie.poster_image
        backdrop.image = movie.backdrop_image
        titleLabel.text = movie.title
        titleLabel.textColor = titleColor
        
        var text = "...".N(size: 30, color: textColor)
        if movie.overview != "" {
            text = "Overview: ".B(size: 21, color: textColor)
            text.append(movie.overview.N(size: 17, color: textColor))
        }
        if movie.release_date != "" {
            text.append("\n\nRealease date: ".B(size: 21, color: textColor))
            text.append(movie.release_date.N(size: 17, color: textColor))
        }
        descriptionLabel.attributedText = text
        star.tintColor = #colorLiteral(red: 0.9112964272, green: 0.7747166753, blue: 0.3718485832, alpha: 1)
        rating.text = "\(movie.vote_average)"
        rating.textColor = textColor
    }
}
