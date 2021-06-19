//
//  String.swift
//  CBook
//
//  Created by Arlin Ropero on 19/06/21.
//

import SwiftyJSON

extension String {
    static func stringToJson(jsonString: String, isArray: Bool = false) -> (Bool, JSON) {
        let jsonData = jsonString.data(using: .utf8)!
        var json = JSON([ ])
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options : .allowFragments) as? [Dictionary<String,Any>] {
                json = JSON(jsonArray)
                return (true, json)
            } else {
                if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options : .allowFragments) as? Dictionary<String,Any> {
                    json = JSON(jsonArray)
                    return (true, json)
                } else {
                    print("bad json")
                    return (false, json)
                }
                
            }
        } catch let error as NSError {
            print(error)
            return (false, json)
        }
    }
}
