//
//   Movies.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//

import SwiftyJSON

extension Webservices {
    
    static func getMovies(page: Int, callbackSuccess: @escaping ([Movie])->Void, callbackFail: @escaping (Errors)->Void){
        Webservices.request(pathMethod: Webservices.MOVIES_URL_SUFFIX, pathMethodXtra: "\(page)", callbackSuccess: {response in
            let results: [JSON] = response?["results"].arrayValue ?? []
            if results.count > 0 {
                var movies: [Movie] = []
                let dispa = DispatchGroup()
                for item in results {
                    dispa.enter()
                    movies.append(Movie(json: item, callback: {dispa.leave()}))
                }
                dispa.notify(queue: .main) {
                    callbackSuccess(movies)
                }

            } else {
                callbackFail(.other)
            }
        }, callbackFailure: { error in
            callbackFail(error)
        })
    }
    
}
