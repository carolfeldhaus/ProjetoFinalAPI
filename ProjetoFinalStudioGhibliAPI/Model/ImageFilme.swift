//
//  ImageFilme.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import Foundation

struct ImageFilme: Codable {
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}
