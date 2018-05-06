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
    
    
    func parse(battles: [Battle]) -> [King]{
        
        var kings = [String: King]()
        
        for battle in battles {
            
            if let king = kings[battle.attackerKing] {
                king.attacksMade += 1
                switch battle.attackerOutcome {
                case .win:
                    king.attacksWon += 1
                case .loose:
                    break
                }
                king.battles.append(battle)
                
            } else {
                
                let attackerKing = King(name: battle.attackerKing)
                attackerKing.attacksMade = 1
                switch battle.attackerOutcome {
                case .win:
                    attackerKing.attacksWon = 1
                case .loose:
                    break
                }
                
                kings[battle.attackerKing] = attackerKing
                attackerKing.battles.append(battle)

            }
            
            if let king = kings[battle.defenderKing] {
                king.defendsMade += 1
                
                switch battle.attackerOutcome {
                case .win:
                    break
                case .loose:
                    king.defendsWon += 1
                }
                
                king.battles.append(battle)

                
            } else {
                
                let defenderKing = King(name: battle.defenderKing, battles: [battle])
                defenderKing.defendsMade = 1
                switch battle.attackerOutcome {
                case .win:
                    break
                case .loose:
                    defenderKing.defendsWon = 1
                }
                
                kings[battle.defenderKing] = defenderKing
                defenderKing.battles.append(battle)
            }
        }
        
        return Array(kings.values)
    }
}

