//
//  KingsListPresenter.swift
//  GameOfThrones
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
//

import Foundation


protocol KingListPresenterOutput {
    
    func showError(message: String)
    
    func showNoContent()
    
    func updateKingsList()
}

class KingsListPresenter {
    
    private var kings: [King]?
    
    let dataRetriever: DataRetriever
    let view: KingListPresenterOutput
    
    init(dataRetriever: DataRetriever, view: KingListPresenterOutput) {
        
        self.dataRetriever = dataRetriever
        self.view = view
    }
    
    func loadAllKings() {
        
        dataRetriever.loadBattles { [weak self] (error, battles) in
            
            guard let strongSelf = self  else { return }
            
            guard error == nil else  {
                strongSelf.view.showError(message: error!.localizedDescription)
                return
            }
            
            guard let battles = battles, !battles.isEmpty else {
                strongSelf.view.showNoContent()
                return
                
            }
            
            let parser = BattleParser()
            strongSelf.kings = parser.parse(battles: battles)
            
            //Business Logic come here
            
            strongSelf.view.updateKingsList()
        }
    }
    
    
    func numberOfKings() -> Int{
       return kings?.count ?? 0
    }
    
    func king(at index: Int) -> King{
        
        return kings![index]
    }
}


class BattleParser {
    
    
    func update(attacker: King, withResultOf battle: Battle) {
        
        attacker.attacksMade += 1
        switch battle.attackerOutcome {
        case .win:
            attacker.attacksWon += 1
        case .loose:
            break
        }
        attacker.battles.append(battle)
    }
    
    func update(defender: King, withResultOf battle: Battle) {
        
        defender.defendsMade += 1
        
        switch battle.attackerOutcome {
        case .win:
            break
        case .loose:
            defender.defendsWon += 1
        }
        
        defender.battles.append(battle)
    }
    
    func parse(battles: [Battle]) -> [King]{
        
        var kings = [String: King]()
        
        for battle in battles {
            
            let attackerKing = (kings[battle.attackerKing] == nil) ? King(name: battle.attackerKing) : kings[battle.attackerKing]!
            update(attacker: attackerKing, withResultOf: battle)
            
            if kings[battle.attackerKing] == nil {
                kings[battle.attackerKing] = attackerKing
            }
            
            let defenderKing = (kings[battle.defenderKing] == nil) ? King(name: battle.defenderKing) : kings[battle.defenderKing]!
            update(defender: defenderKing, withResultOf: battle)
            
            if kings[battle.defenderKing] == nil {
                kings[battle.defenderKing] = defenderKing
            }
        }
        return Array(kings.values)
    }
}

