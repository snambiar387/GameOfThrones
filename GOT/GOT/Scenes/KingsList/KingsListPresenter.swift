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
    
    init(king: King) {
        
    }
}


class KingsListPresenter: KingsListPresenterInput {
    
    weak var view: KingsListPresenterOutput?
    
    init(view: KingsListPresenterOutput) {
        
        self.view = view
    }
    
    func handleError(message: String) {
        
        view?.handleError(message: message)
    }
    
    func showNoContent() {
        view?.showNoContent()
    }
    
    func fetchedKings(kings: [King]) {
        
        view?.update(kings: kings.map { KingViewModel(king: $0) })
    }
}
