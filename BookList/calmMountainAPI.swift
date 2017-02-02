
//
//  File.swift
//  BookList
//
//  Created by Jonathon Day on 2/1/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation
import CoreData

class CalmMountainAPI {
    static let url = URL(string: "https://calm-mountain-87063.herokuapp.com/books.json")!
    
    

    static internal func getBookList(context: NSManagedObjectContext, completion: @escaping (RequestResult) -> ()) {
        getDataFromAPI(completion: completion)
    }
    
    static private func getDataFromAPI(completion: @escaping (RequestResult) -> ()) {
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response else {
                completion(.systemError(error!))
                return
            }
            
            if let data = data {
                let object = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                completion(.success(object))
            } else {
                completion(.networkError(response as! HTTPURLResponse))
            }
        }.resume()
        
    }
}

enum RequestResult {
    case success([[String: Any]])
    case networkError(HTTPURLResponse)
    case systemError(Error)
}
