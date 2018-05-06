//
//  King.swift
//  GameOfThrones
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
//

import Foundation

class King {
    let name: String
    var battles = [Battle]()
    var attacksMade = 0
    var defendsMade = 0
    var attacksWon = 0
    var defendsWon = 0
    var totalBattlesFought = 0
    var totalWin: Int {
        return attacksWon + defendsWon
    }
    
    var eloRating: Double
    
    init(name: String, rating: Double) {
    
        self.name = name
        self.eloRating = rating
    }
}
