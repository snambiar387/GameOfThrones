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
