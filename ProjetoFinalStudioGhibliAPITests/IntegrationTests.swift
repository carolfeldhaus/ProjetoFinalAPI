//
//  IntegrationTests.swift
//  ProjetoFinalStudioGhibliAPITests
//
//  Created by Caroline Feldhaus de Souza on 01/11/21.
//

import XCTest
@testable import ProjetoFinalStudioGhibliAPI

// Criando um duble de testes
class APISpy: sGAPI {
    func setSGURL() -> String {
        return ""
    }
    
    func getSG(urlString: String, method: HTTPMetodo, completion: @escaping (Result<[studioGhibli], SGApiError>) -> Void) {
        apiCalls += 1
    }
    
    
    var apiCalls = 0
    
    func setBreedURL() -> String {
        return ""
    }
    
}

class IntegrationTests: XCTestCase {
    
    /*  func testApiIntegration() {
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
     }*/
    
    func testApiIntegration() {
        let api = API()
        let sut = ViewController(api: api)
        sut.loadViewIfNeeded()
        
        //    sut.populaArrayCat()
        
        let expect = expectation(description: "Aguardar popular gatos")
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(3)
            print(">>>>>> VOU VERIFICAR <<<<<<<")
            guard sut.arrayDeFilmes.count > 0 else {
                XCTFail()
                expect.fulfill()
                return
            }
            let caracterestitulo = sut.arrayDeFilmes[0].title?.count ?? 0
            XCTAssertTrue(caracterestitulo > 0)
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 10.0)
    }
}

