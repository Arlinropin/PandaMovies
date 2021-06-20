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
    
    func getMovies(page: Int, callback: @escaping ([Movie])->Void){
        interactor!.getMovies(page: page, callbackSuccess: callback, callbackFail: { [self] error in
            view!.showModal(texts: ModalText(title: "¡Oops!", message: "Hubo un error en el proceso."))
        })
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
