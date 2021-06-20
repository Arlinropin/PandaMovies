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
    
    func changeToDate(withLocale: Bool = true) -> Date? {
        let dateFormatter = DateFormatter()
        if withLocale{
            dateFormatter.timeZone = TimeZone(identifier: "UTC")!
            dateFormatter.locale = Locale(identifier: "es_CO") // set locale to reliable US_POSIX
        }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        var date = dateFormatter.date(from: self)
        if date == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            date = dateFormatter.date(from: self)
        }
        if date == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            date = dateFormatter.date(from: self)
        }
        if date == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
            date = dateFormatter.date(from: self)
        }
        if date == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            date = dateFormatter.date(from: self)
        }
        return date
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(completion: @escaping (UIImage)->Void){
        print(" ----- Download Started -> \(self)")
        let url = URL(string: self)!
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(#imageLiteral(resourceName: "ico_save_session"))
                return
            }
            print(" +++++ Download Finished -> \(response?.suggestedFilename ?? url.lastPathComponent)")
            DispatchQueue.main.async() {
                completion( UIImage(data: data) ?? UIImage())
            }
        }
    }
}
