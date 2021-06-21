//
//  HomePresenter.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//  
//

import Foundation

class HomePresenter  {
    
    // MARK: Properties
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireFrame: HomeWireFrameProtocol?
    
    func getMovies(page: Int, move: Movement, callback: @escaping ([Movie])->Void){
        interactor!.getMovies(page: page, move: move, callbackSuccess: callback, callbackFail: { [self] error in
            view!.showModal(texts: ModalText(title: "¡Oops!", message: "Hubo un error en el proceso."))
        })
    }
    
    func searchMovie(word: String, search: Search?, move: Movement, callback: @escaping (Search)->Void) {
        interactor!.searchMovie(word: word, search: search, move: move, callbackSuccess: callback, callbackFail: { [self] error in
            switch error {
            case .service,.url,.unknown:
                view!.showModal(texts: ModalText(title: "¡Oops!", message: "Hubo un error en el proceso."))
            case .other:
                view!.showModal(texts: ModalText(title: "¡Lo sentimos!", message: "No encontramos resultados."))
            }
            
        })
    }
    
    func setPageAndGetMovies(isForward: Bool, search: Search?, page: Int){
        if search != nil {
            view!.searchMovie(move: .none)
        } else {
            view!.getMovies(page: page, move: isForward ? .forward:.backward)
        }
    }
}

extension HomePresenter: HomePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
