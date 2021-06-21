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
    @IBOutlet weak var backButton: UIButton!
    
    var presenter: HomePresenterProtocol?

    var cells: [Cell] = []
    var cellHidden: [Cell] = []
    var page: Int = 1
    var movieToSearch: String = ""
    var search: Search?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        table.register(UINib(nibName: CellType.COLLECTION_CELL.rawValue, bundle: Bundle.main),forCellReuseIdentifier: CellType.COLLECTION_CELL.rawValue)
        table.register(UINib(nibName: CellType.SEARCH_CELL.rawValue, bundle: Bundle.main),forCellReuseIdentifier: CellType.SEARCH_CELL.rawValue)
        table.register(UINib(nibName: CellType.OVERVIEW_CELL.rawValue, bundle: Bundle.main),forCellReuseIdentifier: CellType.OVERVIEW_CELL.rawValue)
        table.register(UINib(nibName: CellType.TITLE_CELL.rawValue, bundle: Bundle.main),forCellReuseIdentifier: CellType.TITLE_CELL.rawValue)
        setList()
        getMovies(page: page, move: .none)
    }
    
    func setList(){
        cells = cellHidden
        backButton.isHidden = true
        cells.append(Cell(id: "title", value: "", objects: "", cellType: .TITLE_CELL))
        cells.append(Cell(id: "search", value: movieToSearch, objects: "", cellType: .SEARCH_CELL))
        cells.append(Cell(id: "movies", value: "", objects: [] as [Movie], cellType: .COLLECTION_CELL))
        table.backgroundColor = UIColor(named: "AccentColor")
        table.isScrollEnabled = false
    }
    
    func setOverview(_ movie: Movie){
        cellHidden = cells
        backButton.isHidden = false
        cells = []
        cells.append(Cell(id: "overview", value: "", objects: movie, cellType: .OVERVIEW_CELL))
        table.reloadSections(IndexSet(integer: 0), with: .left)
        table.backgroundColor = movie.color_average_backdrop
        table.isScrollEnabled = true
    }
    
    func getMovies(page: Int, move: Movement) {
        Navigation.showSpinner()
        presenter!.getMovies(page: page, move: move, callback: { [self] movies in
            if let index = cells.firstIndex(where: {$0.id == "movies"}){
                cells[index].objects = movies
            }
            self.page = movies[0].page
            table.reloadData()
            Navigation.closeSpinner()
        })
    }
    
    func searchMovie(move: Movement) {
        Navigation.showSpinner()
        presenter!.searchMovie(word: movieToSearch, search: search, move: move, callback: { [self] search in
            self.search = search
            if let index = cells.firstIndex(where: {$0.id == "movies"}){
                cells[index].objects = search.movies
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
        case .TITLE_CELL:
            let cell = tableView.dequeueReusableCell(withIdentifier: obj.cellType.rawValue, for: indexPath) as! TitleTableViewCell
            cell.callback = {self.update()}
            cell.selectionStyle = .none
            return cell
        case .COLLECTION_CELL:
            let cell = tableView.dequeueReusableCell(withIdentifier: obj.cellType.rawValue, for: indexPath) as! CollectionTableViewCell
            cell.initWithData(page: page, movies: obj.objects as! [Movie], height: tableView.frame.height - 190)
            cell.backwardCallback = { [self] in presenter!.setPageAndGetMovies(isForward: false, search: search, page: page)}
            cell.forwardCallback = { [self] in presenter!.setPageAndGetMovies(isForward: true, search: search, page: page)}
            cell.movieCallback = {movie in self.setOverview(movie)}
            cell.selectionStyle = .none
            return cell
        case .SEARCH_CELL:
            let cell = tableView.dequeueReusableCell(withIdentifier: obj.cellType.rawValue, for: indexPath) as! SearchTableViewCell
            cell.textfield.delegate = self
            cell.textfield.keyboardType = .alphabet
            cell.callbackSearch = {self.searchMovie(move: .none)}
            cell.callbackClean = {self.getMovies(page: self.page, move: .none)}
            cell.selectionStyle = .none
            return cell
        case .OVERVIEW_CELL:
            let cell = tableView.dequeueReusableCell(withIdentifier: obj.cellType.rawValue, for: indexPath) as! DescriptionTableViewCell
            cell.initWithData(movie: obj.objects as! Movie)
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
        let count = text.count + string.count - range.length
        movieToSearch = count > 0 ? text:""
        return true
    }
    
    func update() {
        search = nil
        getMovies(page: page, move: .none)
    }
    
    @IBAction func onBack(_ sender: UIButton) {
        setList()
        table.reloadSections(IndexSet(integer: 0), with: .right)
    }
    
    func showModal(texts: ModalText){
        Navigation.closeSpinner()
        Navigation.showModalView(modalText: texts)
    }
}

extension HomeView: HomeViewProtocol {
    // TODO: implement view output methods
}
