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
    
    let dataRetriever: DataRetriever
    let view: KingListPresenterOutput
    
    init(dataRetriever: DataRetriever, view: KingListPresenterOutput) {
        
        self.dataRetriever = dataRetriever
        self.view = view
    }
    
    func loadAllKings() {
        
        dataRetriever.loadBattles { (error, battles) in
            
            guard error == nil else  {
                view.showError(message: error!.localizedDescription)
                return
            }
            
            guard let battles = battles, !battles.isEmpty else {
                view.showNoContent()
                return
                
            }
            
            //Business Logic come here
            
            view.updateKingsList()
        }
    }
}

