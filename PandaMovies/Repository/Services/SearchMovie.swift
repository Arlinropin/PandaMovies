//
//  SearchMovie.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 20/06/21.
//

import SwiftyJSON

extension Webservices {
    
    static func searchMovie(word: String, page: Int, callbackSuccess: @escaping (Search)->Void, callbackFail: @escaping (Errors)->Void){
        Webservices.request(pathMethod: Webservices.SEARCH_URL_SUFFIX, pathMethodXtra: "query=\(word)&page=\(page)", callbackSuccess: {response in
            if response?["total_results"].intValue ?? 0 > 0 {
                let dispa = DispatchGroup()
                dispa.enter()
                let search = Search(json: response!, callback: {dispa.leave()})
                dispa.notify(queue: .main) {
                    callbackSuccess(search)
                }
            } else {
                callbackFail(.other)
            }
        }, callbackFailure: { error in
            callbackFail(error)
        })
    }
    
}
