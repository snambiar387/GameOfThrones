//
//  KingsListPresenter.swift
//  GOT
//
//  Created by macadmin on 5/12/18.
//  Copyright © 2018 macadmin. All rights reserved.
//

import Foundation

protocol ErrorHandler {
    
    func handleError(message: String)
    
    func showNoContent()
}

protocol KingsListPresenterInput: ErrorHandler {
    
    func fetchedKings(kings: [King])
}

protocol KingsListPresenterOutput:class, ErrorHandler {
    
    func update(kings: [KingViewModel])
    
}

//TODO: IMPLEMENT COPY-ON-WRITE

struct KingViewModel {
    
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


class KingsListPresenter: KingsListPresenterInput {
    
    weak var view: KingsListPresenterOutput?
    
    init(view: KingsListPresenterOutput) {
        
        self.view = view
    }
    
    func handleError(message: String) {
        
        DispatchQueue.main.async {
           self.view?.handleError(message: message)
        }
    }
    
    func showNoContent() {
        DispatchQueue.main.async {
            self.view?.showNoContent()
        }
    }
    
    func fetchedKings(kings: [King]) {
        DispatchQueue.main.async {
            self.view?.update(kings: kings.map { KingViewModel(king: $0) })
        }
    }
}
