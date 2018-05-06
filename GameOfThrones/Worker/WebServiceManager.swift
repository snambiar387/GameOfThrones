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
    
    func loadBattles(completionHandler: (Error?, [Battle]?) -> Void) {
        
        let url = "http://starlord.hackerearth.com/gotjson"
        
        Alamofire.request(url, method: .get, parameters: nil)
    }
}
