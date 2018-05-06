//
//  GameOfThronesTests.swift
//  GameOfThronesTests
//
//  Created by Liny Thomas on 5/6/18.
//  Copyright © 2018 Sreehari. All rights reserved.
//

import XCTest
@testable import GameOfThrones

class MockDataRetriever: DataRetriever {
    
    func loadBattles(completionHandler: @escaping (Error?, [Battle]?) -> Void) {
        
        completionHandler(nil, [Battle]())
    }
}

class MockView: KingListPresenterOutput {
    
    func showNoContent() {
        print("Load no content view")
    }
    
    func showError(message: String) {
        print("Error \(message)")
    }
    
    func updateKingsList() {
        print("Reload view")
    }
}

class GameOfThronesTests: XCTestCase {
    
    var presenter = KingsListPresenter(dataRetriever: MockDataRetriever(), view: MockView())
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        
        
        super.tearDown()
    }
    
    func testNoContentIsDisplayedOnEmptyBattles() {
        
        presenter.loadAllKings()
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
