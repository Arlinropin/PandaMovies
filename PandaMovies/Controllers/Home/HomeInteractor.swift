//
//  HomeInteractor.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//  
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: HomeInteractorOutputProtocol?
    
    func getMovies(page: Int, callbackSuccess: @escaping ([Movie])->Void, callbackFail: @escaping (Errors)->Void) {
        Webservices.getMovies(page: page, callbackSuccess: {movies in
            callbackSuccess(movies)
        }, callbackFail: callbackFail)
    }
}

