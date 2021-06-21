//
//  Search.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 20/06/21.
//

import SwiftyJSON

class Search {
    var page: Int
    var movies: [Movie] = []
    var total_pages: Int
    var total_results: Int
    
    init(json: JSON, callback: @escaping ()->Void) {
        page = json["page"].intValue
        total_pages = json["total_pages"].intValue
        total_results = json["total_results"].intValue
        let moviesArrayJson = json["results"].arrayValue
        let dispa = DispatchGroup()
        for item in moviesArrayJson {
            dispa.enter()
            movies.append(Movie(json: item, callback: {dispa.leave()}))
        }
        dispa.notify(queue: .main) {
            callback()
        }
    }

}
