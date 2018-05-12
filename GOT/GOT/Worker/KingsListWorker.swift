

//
//  File.swift
//  GOT
//
//  Created by macadmin on 5/12/18.
//  Copyright © 2018 macadmin. All rights reserved.
//

import Foundation

enum Result<A> {
    case error(message: String)
    case success(result: A)
}

typealias FetchKingsListCompletionHandler = (Result<[Battle]>) -> Void

protocol KingsListStore {
    
    //CRUD operation based on use case goes here.
    //This protocol methods can take params based on the query to make. Construct a generic request model(for API calls) and call a generic API handler
    
    func loadBattles(completionHandler: @escaping FetchKingsListCompletionHandler)
    
}


class KingsListDataStore: KingsListStore {
    
    
    func loadBattles(completionHandler: @escaping FetchKingsListCompletionHandler) {
        
        let url = "http://starlord.hackerearth.com/gotjson"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let session = URLSession.shared

        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completionHandler(Result.error(message: error!.localizedDescription))
                return
            }
            
            guard let data = data else {
                completionHandler(Result.error(message: "Unknown error Ocuured!!!"))
                return
            }
            
            do {
                let battleJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                
                guard let battleInfo = battleJson as? [[String: AnyObject]] else { return }
                
                let battles = battleInfo.map { Battle(dictionary: $0) }.flatMap{ $0 }
                
                completionHandler(Result.success(result: battles))
                
                
            } catch let error as NSError {
                completionHandler(Result.error(message: error.localizedDescription))
            }
        }
        
        dataTask.resume()
    }
}

