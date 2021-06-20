//
//  HomeView.swift
//  PandaMovies
//
//  Created by Arlin Ropero on 19/06/21.
//  
//

import Foundation
import UIKit

class HomeView: BaseController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var presenter: HomePresenterProtocol?

    var cells: [Cell] = []
    var page: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        table.register(UINib(nibName: CellType.COLLECTION_CELL.rawValue, bundle: Bundle.main),forCellReuseIdentifier: CellType.COLLECTION_CELL.rawValue)
        table.register(UINib(nibName: CellType.SEARCH_CELL.rawValue, bundle: Bundle.main),forCellReuseIdentifier: CellType.SEARCH_CELL.rawValue)
        cells.append(Cell(id: "search", label: "", value: "", objects: "", cellType: .SEARCH_CELL))
        cells.append(Cell(id: "movies", label: "", value: "", objects: [] as [Movie], cellType: .COLLECTION_CELL))
        
        getMovies(page: page)
    }
    
    func getMovies(page: Int) {
        Navigation.showSpinner()
        presenter!.getMovies(page: page, callback: { [self] movies in
            if let index = cells.firstIndex(where: {$0.id == "movies"}){
                cells[index].objects = movies
            }
            table.reloadData()
            Navigation.closeSpinner()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = cells[indexPath.row]
        switch obj.cellType {
        case .COLLECTION_CELL:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellType.COLLECTION_CELL.rawValue, for: indexPath) as! CollectionTableViewCell
            cell.initWithData(page: page, movies: obj.objects as! [Movie], height: tableView.frame.height - 80)
            cell.backwardCallback = {self.setPageAndGetMovies(isForward: false)}
            cell.forwardCallback = {self.setPageAndGetMovies(isForward: true)}
            cell.selectionStyle = .none
            return cell
        case .SEARCH_CELL:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellType.SEARCH_CELL.rawValue, for: indexPath) as! SearchTableViewCell
            cell.textfield.delegate = self
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func setPageAndGetMovies(isForward: Bool){
        page = isForward ? page + 1: (page > 1 ? page - 1 : page)
        getMovies(page: page)
    }
    
    @IBAction func update(_ sender: UIButton) {
        getMovies(page: page)
    }
    
    func showModal(texts: ModalText){
        Navigation.closeSpinner()
        Navigation.showModalView(modalText: texts)
    }
}

extension HomeView: HomeViewProtocol {
    // TODO: implement view output methods
}
