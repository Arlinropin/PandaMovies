//
//  HomeInteractor.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//  
//

import UIKit

class HomeInteractor: HomeInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: HomeInteractorOutputProtocol?
    
    func getMovies(page: Int, move: Movement, callbackSuccess: @escaping ([Movie])->Void, callbackFail: @escaping (Errors)->Void) {
        let page: Int = setPage(page, move)
        Webservices.getMovies(page: page, callbackSuccess: { [self]movies in
            let movies = modifyMovies(movies: movies, page: page)
            callbackSuccess(movies)
        }, callbackFail: callbackFail)
    }
    
    func searchMovie(word: String, search: Search?, move: Movement, callbackSuccess: @escaping (Search)->Void, callbackFail: @escaping (Errors)->Void){
        let wordToSearch = word.trimmingCharacters(in: .whitespacesAndNewlines)
        var page = 1
        if search != nil {
            page = setPage(search!.page, move, search!.total_pages)
        }
        Webservices.searchMovie(word: wordToSearch, page: page, callbackSuccess: { [self]search in
            let movies = modifyMovies(movies: search.movies, page: page)
            let search = search
            search.movies = movies
            callbackSuccess(search)
        }, callbackFail: callbackFail)
    }
    
    func setPage(_ page: Int,_ move: Movement,_ totalPages: Int = 0) -> Int {
        var page = page
        if totalPages > 0 {
            page = move == .forward ? (totalPages > page ? page + 1: page) : (page > 1 ? page - 1 : page)
        } else {
            page = move == .forward ? page + 1 : (page > 1 ? page - 1 : page)
        }
        return page
    }
    
    func modifyMovies (movies: [Movie], page: Int) -> [Movie]{
        let movies = movies
        for index in 0..<movies.count {
            if movies[index].backdrop_image ==  #imageLiteral(resourceName: "PandaSearch") {
                movies[index].backdrop_image = movies[index].poster_image
            }
            movies[index].color_average_backdrop = movies[index].backdrop_image.averageColor ?? UIColor.white
            movies[index].ineverse_color_average_backdrop = movies[index].color_average_backdrop.inverseColor()
            movies[index].vote_average = round(movies[index].vote_average * 10) / 10.0
            movies[index].page = page
        }
        return movies
    }
}

