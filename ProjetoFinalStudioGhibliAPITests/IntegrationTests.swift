//
//  IntegrationTests.swift
//  ProjetoFinalStudioGhibliAPITests
//
//  Created by Caroline Feldhaus de Souza on 01/11/21.
//

import XCTest

@testable import ProjetoFinalStudioGhibliAPI

class IntegrationTests: XCTestCase {

    func testApiIntegration() {
            let sut = ViewController()
            sut.loadViewIfNeeded()

            sut.populaArrayDeFilmes()

            let expect = expectation(description: "Aguardando")

            DispatchQueue.global(qos: .userInitiated).async {
              
                sleep(3)
               
                print("Verificando")
                guard sut.arrayDeFilmes.count > 0 else {
                    XCTFail()
                    expect.fulfill()
                    return
                }
                let teste = sut.arrayDeFilmes[0].title?.count ?? 0
                XCTAssertTrue(teste > 0)
                expect.fulfill()
            }

            wait(for: [expect], timeout: 10.0)
        }
}
