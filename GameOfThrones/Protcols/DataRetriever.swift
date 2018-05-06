//
//  DataRetriever.swift
//  GameOfThrones
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
//

import Foundation

//TODO:
enum Result<A> {
    
    case failed(Error)
    case success(A)
}


protocol DataRetriever {
    
    func loadBattles(completionHandler: (Error?, [Battle]?) -> Void) -> Void
    
}
