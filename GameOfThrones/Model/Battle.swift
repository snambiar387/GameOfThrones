//
//  Battle.swift
//  GameOfThrones
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
//

import Foundation

enum BattleResult {
    case win
    case loose
}

class Battle {
    
    /*
     "name": "Battle of the Golden Tooth",
     "year": 298,
     "battle_number": 1,
     "attacker_king": "Joffrey/Tommen Baratheon",
     "defender_king": "Robb Stark",
     "attacker_1": "Lannister",
     "attacker_2": "",
     "attacker_3": "",
     "attacker_4": "",
     "defender_1": "Tully",
     "defender_2": "",
     "defender_3": "",
     "defender_4": "",
     "attacker_outcome": "win",
     "battle_type": "pitched battle",
     "major_death": 1,
     "major_capture": 0,
     "attacker_size": "15000",
     "defender_size": "4000",
     "attacker_commander": "Jaime Lannister",
     "defender_commander": "Clement Piper, Vance",
     "summer": "1",
     "location": "Golden Tooth",
     "region": "The Westerlands",
     "note": ""
 
    */
    
    var name: String
    //var year: Int
    var battleNumber: Int
    var attackerKing: String
    var defenderKing: String
    //var location: String?
    var attackerOutcome: BattleResult
    
    init?(dictionary: [String : AnyObject]) {
        
        guard let name = dictionary["name"] as? String, let battleNumber = dictionary["battle_number"] as? Int, let attackerKing = dictionary["attacker_king"] as? String, let defenderKing = dictionary["defender_king"] as? String, let outcome = dictionary["attacker_outcome"] as? String  else {
            return nil
        }
        
        self.name = name
        self.battleNumber = battleNumber
        self.attackerKing = attackerKing
        self.defenderKing = defenderKing
        self.attackerOutcome = (outcome == "win") ? .win : .loose
    }
}
