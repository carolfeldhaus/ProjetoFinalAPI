//
//  IntegrationTests.swift
//  ProjetoFinalStudioGhibliAPITests
//
//  Created by Caroline Feldhaus de Souza on 01/11/21.
//

import XCTest
@testable import ProjetoFinalStudioGhibliAPI

// Criando um duble de testes
class APISpy: API {
    
    var apiCalls = 0
    
    func setBreedURL() -> String {
        return ""
    }
    
    func getCats(urlString: String, method: HTTPMetodo, completion: @escaping (Result<[studioGhibli], SGApiError>) -> Void) {
        apiCalls += 1
    }
   
}

class IntegrationTests: XCTestCase {

    func testApiIntegration() {
        // Setup
        let api = API()
        let sut = ViewController(api: api)
        sut.loadViewIfNeeded()
        
        //Exercise
        sleep(5)
        guard sut.arrayDeFilmes.count > 0 else {
            XCTFail()
            return
        }
        
        // Verify
        let charactersFromTheFirstMovie = sut.arrayDeFilmes[0].title?.count ?? 0
        XCTAssertTrue(charactersFromTheFirstMovie > 0)
    }

}
