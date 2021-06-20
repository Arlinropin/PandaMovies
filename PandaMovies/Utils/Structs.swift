//
//  Structs.swift
//  CBook
//
//  Created by Arlin Ropero on 19/06/21.
//

import Foundation

// MARK: Tipos de errores
enum Errors {
    case service
    case url
    case unknown
    case other
}

struct ModalText {
    var title: String
    var message: String
}

// MARK: Celda
struct Cell {
    var id: String
    var label: String
    var value: Any
    var objects: Any
    var cellType: CellType
}

enum CellType: String {
    case POSTER_CELL = "PosterCollectionViewCell"
    case COLLECTION_CELL = "CollectionTableViewCell"
    case SEARCH_CELL = "SearchTableViewCell"
    case OVERVIEW_CELL = "DescriptionTableViewCell"
    case TITLE_CELL = "TitleTableViewCell"
}
