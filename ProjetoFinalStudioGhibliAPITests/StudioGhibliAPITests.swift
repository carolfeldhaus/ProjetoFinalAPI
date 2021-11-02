//
//  ProjetoFinalStudioGhibliAPITests.swift
//  ProjetoFinalStudioGhibliAPITests
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import XCTest
@testable import ProjetoFinalStudioGhibliAPI

class testeapi: XCTestCase {
    
    func testInitWillCallApiOnce() {
        // Setup
        let doubleApi = APISpy()
        let sut = ViewController(api: doubleApi)
        
        // Exercise
        sut.loadViewIfNeeded()
        
        // Verify
        XCTAssertEqual(doubleApi.apiCalls, 1, "A API deve ser chamada somente uma vez")
    }
}
