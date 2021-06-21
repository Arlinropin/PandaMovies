//
//  HomeProtocols.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//  
//

import Foundation
import UIKit

protocol HomeViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: HomePresenterProtocol? { get set }
    func showModal(texts: ModalText)
    func getMovies(page: Int, move: Movement)
    func searchMovie(move: Movement)
}

protocol HomeWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createHomeModule() -> UIViewController
}

protocol HomePresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var wireFrame: HomeWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func getMovies(page: Int, move: Movement, callback: @escaping ([Movie])->Void)
    func searchMovie(word: String, search: Search?, move: Movement, callback: @escaping (Search)->Void)
    func setPageAndGetMovies(isForward: Bool, search: Search?, page: Int)
}

protocol HomeInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol HomeInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: HomeInteractorOutputProtocol? { get set }
    func getMovies(page: Int, move: Movement, callbackSuccess: @escaping ([Movie])->Void, callbackFail: @escaping (Errors)->Void)
    func searchMovie(word: String, search: Search?, move: Movement, callbackSuccess: @escaping (Search)->Void, callbackFail: @escaping (Errors)->Void)
}



