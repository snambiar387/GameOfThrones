//
//  KingsListInteractor.swift
//  GOT
//
//  Created by macadmin on 5/12/18.
//  Copyright © 2018 macadmin. All rights reserved.
//

import Foundation

protocol KingsListBusinessLogic {
    
    func fetchKings()
}

class KingsListInteractor: KingsListBusinessLogic {
    
    let presenter: KingsListPresenterInput
    let dataStore: KingsListStore
    private var kings: [King]!
    
    init(presenter: KingsListPresenterInput, dataStore: KingsListStore) {
        
        self.presenter = presenter
        self.dataStore = dataStore
    }
    
    func process(battles: [Battle]) {
        
        guard !battles.isEmpty else {
            
            presenter.showNoContent()
            return
        }
        
        //TODO: Improve the code
        let parser = BattleParser()
        kings = parser.parse(battles: battles)
        
        presenter.fetchedKings(kings: kings)
        
    }
    
    func fetchKings() {
        
        dataStore.loadBattles {[weak self] (result) in
            
            guard let strongSelf = self else { return }
            
            switch result {
                
            case .error(let message):
                strongSelf.presenter.handleError(message: message)
                
            case .success(let battles):
                strongSelf.process(battles: battles)
            }
        }
    }
}
