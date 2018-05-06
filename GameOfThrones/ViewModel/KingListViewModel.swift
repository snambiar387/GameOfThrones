//
//  KingListViewModel.swift
//  GameOfThrones
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
//

import Foundation

struct KingListViewModel {
    
    let name: String
    let attacksMade: String
    let defendsMade: String
    let totalWin: String
    let eloRating: String
    
    init(king: King) {
        
        name = king.name
        attacksMade = "\(king.attacksMade)"
        defendsMade = "\(king.defendsMade)"
        totalWin = "\(king.totalWin)"
        eloRating = "\(king.eloRating)"
    }
}
