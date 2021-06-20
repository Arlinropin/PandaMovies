//
//  Movie.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//

import SwiftyJSON
import UIKit

class Movie {
    
    var overview : String
    var title : String
    var original_title : String
    var adult : Bool
    var vote_count : Int
    var video : Bool
    var backdrop_path : String
    var vote_average : Double
    var poster_path : String
    var release_date : String
    var id : String
    var popularity : Double
    var genre_ids : [Int] = []
    var original_language : String
    var poster_image: UIImage
    var backdrop_image: UIImage
    
    init(json: JSON, callback: @escaping ()->Void) {
        var paths: [String] = []
        overview = json["overview"].stringValue
        title = json["title"].stringValue
        original_title = json["original_title"].stringValue
        adult = json["adult"].boolValue
        vote_count = json["vote_count"].intValue
        video = json["video"].boolValue
        backdrop_path = json["backdrop_path"].stringValue
        paths.append(backdrop_path)
        vote_average = json["vote_average"].doubleValue
        poster_path = json["poster_path"].stringValue
        paths.append(poster_path)
        release_date = json["release_date"].stringValue
        id = json["id"].stringValue
        popularity = json["popularity"].doubleValue
        let genreIds = json["genre_ids"].arrayValue
        for item in genreIds{
            genre_ids.append(item.intValue)
        }
        original_language = json["original_language"].stringValue
        poster_image = UIImage()
        backdrop_image = UIImage()
        let dispa = DispatchGroup()
        for index in 0..<paths.count {
            dispa.enter()
            if paths[index] == "" {
                if index == 0{
                    self.backdrop_image = #imageLiteral(resourceName: "PandaSearch")
                    print("*-*-*-* No hay path de backdrop_image *-*-*-*")
                } else {
                    self.poster_image =  #imageLiteral(resourceName: "PandaSearch")
                    print("*-*-*-* No hay path de poster_image *-*-*-*")
                }
                dispa.leave()
            } else {
                let path: String = ("https://image.tmdb.org/t/p/w500" + paths[index].replacingOccurrences(of: "\\", with: ""))
                path.downloadImage(completion: { image in
                    if index == 0{
                        self.backdrop_image = image
                    } else {
                        self.poster_image =  image
                    }
                    dispa.leave()
                })
            }
        }
        dispa.notify(queue: .main) {
            callback()
        }
    }
}
