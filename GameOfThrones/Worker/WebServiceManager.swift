//
//  WebServiceManager.swift
//  GameOfThrones
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
//

import Foundation
import Alamofire

class WebServiceManager: DataRetriever {
    
    func loadBattles(completionHandler: @escaping (Error?, [Battle]?) -> Void) {
        
        let url = "http://starlord.hackerearth.com/gotjson"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completionHandler(error , nil)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let battleJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                
                guard let battleInfo = battleJson as? [[String: AnyObject]] else { return }
                
                let battles = battleInfo.map { Battle(dictionary: $0) }.flatMap{ $0 }
                
                completionHandler(nil , battles)

                
            } catch let error as NSError {
                completionHandler(error , nil)
            }
        }
        dataTask.resume()
    }
}
