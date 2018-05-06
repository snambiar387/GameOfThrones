//
//  Battle.swift
//  GameOfThrones
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
//

import Foundation

struct Battle: Codable {
    
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
    
    var name: String?
    var year: Int?
    var battleNumber: Int?
    var attackerKing: String?
    var defenderKing: String?
    var attacker1: String?
    var attacker2: String?
    var attacker3: String?
    var attacker4: String?
    var defender1: String?
    var defender2: String?
    var defender3: String?
    var defender4: String?
    var attackerOutcome: String?
    var battleType: String?
    var majorDeath: Int?
    var majorCapture: Int?
    var attackerSize: Int?
    var defenderSize: Int?
    var attackerCommander: String?
    var defenderCommander: String?
    var summer: Int?
    var location: String?
    var region: String?
    var note: String?
    
    
    init(dictionary: [String : AnyObject]) {
        name = dictionary["name"] as? String
        attacker1 = dictionary["attacker_1"] as? String
        attacker2 = dictionary["attacker_2"] as? String
        attackerKing = dictionary["attacker_king"] as? String
        attackerOutcome = dictionary["attacker_outcome"] as? String
        attackerSize = Int((dictionary["attacker_size"] as? String)!) ?? 0
        defenderSize = Int((dictionary["defender_size"] as? String)!) ?? 0
        
    }
}
