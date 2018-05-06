//
//  KingsListPresenter.swift
//  GameOfThrones
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
//

import Foundation

struct Constants {
    
    static let defaultELORating: Double = 400.0
}

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
    
    func king(at index: Int) -> KingListViewModel{
        
        let king = kings![index]
        return KingListViewModel(king: king)
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
            
            let attackerKing = (kings[battle.attackerKing] == nil) ? King(name: battle.attackerKing, rating: Constants.defaultELORating) : kings[battle.attackerKing]!
            update(attacker: attackerKing, withResultOf: battle)
            
            if kings[battle.attackerKing] == nil {
                kings[battle.attackerKing] = attackerKing
            }
            
            let defenderKing = (kings[battle.defenderKing] == nil) ? King(name: battle.defenderKing, rating: Constants.defaultELORating) : kings[battle.defenderKing]!
            update(defender: defenderKing, withResultOf: battle)
            
            if kings[battle.defenderKing] == nil {
                kings[battle.defenderKing] = defenderKing
            }
            
            let attackerTotalLoss = attackerKing.totalBattlesFought - attackerKing.totalWin
            let attackerELO = (defenderKing.eloRating + Constants.defaultELORating * Double(( attackerKing.totalWin -  attackerTotalLoss))) 
            attackerKing.eloRating = attackerELO
            
            let defenderTotalLoss = defenderKing.totalBattlesFought - attackerKing.totalWin
            let defenderELO = attackerKing.eloRating + Constants.defaultELORating * Double(( defenderKing.totalWin -  defenderTotalLoss ))
            defenderKing.eloRating = defenderELO
        }
        return Array(kings.values)
    }
}

