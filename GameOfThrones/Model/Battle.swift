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
    
    let name: String
    let year: Int
    let battleNumber: Int
    let attackerKing: String
    let defenderKing: String
    let attacker1: String
    let attacker2: String
    let attacker3: String
    let attacker4: String
    let defender1: String
    let defender2: String
    let defender3: String
    let defender4: String
    let attackerOutcome: String
    let battleType: String
    let majorDeath: Int
    let majorCapture: Int
    let attackerSize: Int
    let defenderSize: Int
    let attackerCommander: String
    let defenderCommander: String
    let summer: Int
    let location: String
    let region: String
    let note: String
    
    private enum CodinKeys: String, CodingKey{
        case name, year, battleNumber = "battle_number", attackerKing = "attacker_king", defenderKing = "defender_king", attacker1 = "attacker_1", attacker2 = "attacker_2", attacker3 = "attacker_3", attacker4 = "attacker_4", defender1 = "defender_1", defender2 = "defender_2", defender3 = "defender_3", defender4 = "defender_4", attackerOutcome = "attacker_outcome", battleType = "battle_type", majorDeath = "major_death", majorCapture = "major_capture", attackerSize = "attacker_size", defenderSize = "defender_size", attackerCommander = "attacker_commander", defenderCommander = "defender_commander", summer, location, region, note
    }
}
