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
    
    init(name: String) {
        
        self.name = name
    }
    
    var attacksMade = 0
    var defendsMade = 0
    var attacksWon = 0
    var defendsWon = 0
    var totalBattlesFought = 0
    
    init(name: String, battles: [Battle]) {
        self.name = name
        self.battles = battles
    }
}
