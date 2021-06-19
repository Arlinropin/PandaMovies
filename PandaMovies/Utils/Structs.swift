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

enum CellType: String {
    case USER_CELL = "UserTableViewCell"
    case POST_CELL = "PostTableViewCell"
}
